package murach.business;

import java.io.Serializable;
import java.util.Objects;

public class User implements Serializable {

    // --- THÔNG TIN CƠ BẢN (Từ các trường Input) ---
    private String firstName;
    private String lastName;
    private String email;
    private String dob; // Date of Birth

    // --- THÔNG TIN KHẢO SÁT (Từ Radio, Checkbox, Select) ---
    private String source; // How did you hear about us? (Radio button)
    private String receiveCDs; // YES/No for CDs (Checkbox)
    private String receiveEmail; // YES/No for Email announcements (Checkbox)
    private String contactMethod; // Contact method (Select box)

    // --- CONSTRUCTORS ---
    public User() {
        this.firstName = "";
        this.lastName = "";
        this.email = "";
        this.dob = "";
        this.source = "";
        this.receiveCDs = "No"; // Mặc định là "No" nếu checkbox không được chọn
        this.receiveEmail = "No"; // Mặc định là "No" nếu checkbox không được chọn
        this.contactMethod = "Email or postal mail";
    }

    // Constructor đơn giản cho các trường bắt buộc (Có thể thêm constructor đầy đủ nếu cần)
    public User(String firstName, String lastName, String email) {
        this(); // Gọi constructor mặc định để khởi tạo các trường khác
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
    }

    // --- GETTERS & SETTERS CHO CÁC TRƯỜNG MỚI VÀ CŨ ---

    // 1. Thông tin cơ bản
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getDob() { return dob; }
    public void setDob(String dob) { this.dob = dob; }

    // 2. Thông tin khảo sát
    public String getSource() { return source; }
    public void setSource(String source) { this.source = source; }

    // Lưu ý: Các Checkbox chỉ gửi giá trị "Yes" nếu được chọn. Nếu không chọn, chúng không gửi gì.
    // Trong Servlet, nếu tham số là null, bạn nên xử lý là "No".
    public String getReceiveCDs() { return receiveCDs; }
    public void setReceiveCDs(String receiveCDs) {
        this.receiveCDs = (receiveCDs != null) ? receiveCDs : "No";
    }

    public String getReceiveEmail() { return receiveEmail; }
    public void setReceiveEmail(String receiveEmail) {
        this.receiveEmail = (receiveEmail != null) ? receiveEmail : "No";
    }

    public String getContactMethod() { return contactMethod; }
    public void setContactMethod(String contactMethod) { this.contactMethod = contactMethod; }

    // --- PHƯƠNG THỨC BỔ SUNG (Giữ nguyên) ---

    @Override
    public String toString() {
        return "User{" +
                "firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", email='" + email + '\'' +
                ", dob='" + dob + '\'' +
                ", source='" + source + '\'' +
                ", receiveCDs='" + receiveCDs + '\'' +
                ", receiveEmail='" + receiveEmail + '\'' +
                ", contactMethod='" + contactMethod + '\'' +
                '}';
    }
}