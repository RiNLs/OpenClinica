package core.org.akaza.openclinica.web.pform.dto;

public class Html {
	
	private Head head;
	private Body body;
	
	public Html() {}
	
	public Html(Html html) {
		setHead(html.getHead());
		setBody(html.getBody());
	}	
	public Head getHead() {
		return head;
	}	
	public void setHead(Head head) {
		this.head = head;
	}	
	public Body getBody() {
		return body;
	}	
	public void setBody(Body body) {
		this.body = body;
	}
}