import os
import re

def check_file(filepath):
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        # print(f"Error reading {filepath}: {e}")
        return []
    
    problems = []
    lines = [line.strip() for line in content.split('\n')]
    
    # Check for unused imports
    imports = [line for line in lines if line.startswith('import ') and not '*' in line]
    for imp in imports:
        # Get class name
        match = re.search(r'import\s+[\w\.]+\.([\w$]+);', imp)
        if match:
            class_name = match.group(1)
            # count total occurrences
            # check the whole content for class name occurrences, excluding the import statement itself
            # use word boundaries to avoid false positives
            pattern = rf'\b{re.escape(class_name)}\b'
            all_matches = re.findall(pattern, content)
            
            # The class name is mentioned once in the import line.
            # If it's mentioned only once, it's unused.
            # Actually, some classes might be mentioned multiple times but not used? 
            # In simple cases, if count is 1, it's unused.
            if len(all_matches) == 1:
                problems.append(f"Unused import: {imp}")

    # Check for unused private fields
    # (Matches simple private String field; or private List<String> field;)
    # use word boundaries for re.search
    field_lines = [line for line in lines if line.startswith('private ') and ';' in line]
    for field in field_lines:
        match = re.search(r'private\s+[\w<>]+\s+(\w+)\s*;', field)
        if match:
            field_name = match.group(1)
            pattern = rf'\b{re.escape(field_name)}\b'
            all_matches = re.findall(pattern, content)
            if len(all_matches) == 1: # only once in definition
                problems.append(f"Unused field: {field}")
                
    return problems

def main():
    all_problems = {}
    for root, dirs, files in os.walk('.'):
        if any(x in root for x in [".git", "target", ".idea", "node_modules"]):
            continue
        for file in files:
            if file.endswith('.java'):
                path = os.path.join(root, file)
                probs = check_file(path)
                if probs:
                    all_problems[path] = probs
    
    for path, probs in all_problems.items():
        print(f"File: {path}")
        for p in probs:
            print(f"  - {p}")

if __name__ == '__main__':
    main()
