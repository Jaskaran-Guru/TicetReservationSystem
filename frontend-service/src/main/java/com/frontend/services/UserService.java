package com.frontend.services;

import org.springframework.stereotype.Service;
import jakarta.servlet.http.HttpSession;
import java.util.*;

@Service
public class UserService {

    public void setUserSession(HttpSession session, Map<String, Object> userData) {
        session.setAttribute("user", userData);
        session.setAttribute("isLoggedIn", true);
        session.setAttribute("isAdmin", "ADMIN".equals(userData.get("role")));
    }

    public void clearUserSession(HttpSession session) {
        session.removeAttribute("user");
        session.removeAttribute("isLoggedIn");
        session.removeAttribute("isAdmin");
        session.invalidate();
    }

    public Map<String, Object> getCurrentUser(HttpSession session) {
        @SuppressWarnings("unchecked")
        Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
        return user != null ? user : new HashMap<>();
    }

    public boolean isLoggedIn(HttpSession session) {
        Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
        return isLoggedIn != null && isLoggedIn;
    }

    public boolean isAdmin(HttpSession session) {
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        return isAdmin != null && isAdmin;
    }

    public String getUserId(HttpSession session) {
        Map<String, Object> user = getCurrentUser(session);
        return (String) user.get("id");
    }

    public Map<String, Object> getSessionInfo(HttpSession session) {
        Map<String, Object> sessionInfo = new HashMap<>();
        sessionInfo.put("user", getCurrentUser(session));
        sessionInfo.put("isLoggedIn", isLoggedIn(session));
        sessionInfo.put("isAdmin", isAdmin(session));
        sessionInfo.put("sessionId", session.getId());
        return sessionInfo;
    }
}
