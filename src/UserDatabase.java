import java.util.List;

public class UserDatabase {
	List<User> users;

	public UserDatabase(List<User> users) {
		this.users = users;
	}
	
	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}
}
