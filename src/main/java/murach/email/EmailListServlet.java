package murach.email;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import murach.business.User;
import murach.data.UserDB;

public class EmailListServlet extends HttpServlet  {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String url = "/index.html";

        // get current action
        String action = request.getParameter("action");
        if (action == null) {
            action = "join";  // default action
        }
        // perform action and set URL to appropriate page
        if (action.equals("join")) {
            url = "/index.html";    // the "join" page
        }
        else if (action.equals("add")) {
            // get parameters from the request
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String dob = request.getParameter("dob");
            String source = request.getParameter("source");
            String receiveCDs = request.getParameter("receiveCDs"); // Checkbox: có thể là null
            String receiveEmail = request.getParameter("receiveEmail"); // Checkbox: có thể là null
            String contactMethod = request.getParameter("contact_method");

            // store data in User object and save User object in db
            User user = new User(firstName, lastName, email); // Dùng constructor cũ (chỉ 3 tham số)
            user.setDob(dob);
            user.setSource(source);
            user.setReceiveCDs(receiveCDs); // Lớp User sẽ xử lý null thành "No"
            user.setReceiveEmail(receiveEmail);
            user.setContactMethod(contactMethod);
//            UserDB.insert(user);
//
            // set User object in request object and set URL
            request.setAttribute("user", user);
            url = "/thanks.jsp";   // the "thanks" page
        }

        // forward request and response objects to specified URL
        getServletContext()
                .getRequestDispatcher(url)
                .forward(request, response);
    }
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}