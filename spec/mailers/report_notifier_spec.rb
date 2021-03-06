require "spec_helper"

describe ReportNotifier do
  before :each do
    @application = mock_model(Application, :id => "2")
    @comment = mock_model(Comment, :application => @application, :text => "I'm saying something abusive",
      :name => "Jack Rude", :email => "rude@foo.com", :id => "23")
    @report = mock_model(Report, :name => "Joe Reporter", :email => "reporter@foo.com", :comment => @comment,
      :details => "This is very rude!")
    @notifier = ReportNotifier.notify(@report)
  end
  
  it "should come from the same email address as the email alerts come from" do
    @notifier.from.should == ["contact@planningalerts.org.au"]
  end
  
  it "should go to the moderator email address" do
    @notifier.to.should == ["contact@planningalerts.org.au"]
  end
  
  it "should tell the moderator what the email is about" do
    @notifier.subject.should == "PlanningAlerts.org.au: Abuse report"
  end
  
  it "should tell the moderator everything they need to know to decide on what to do with the report" do
    @notifier.body.should == <<-EOF
The abuse report was completed by Joe Reporter (reporter@foo.com) who said:
This is very rude!

The original comment was written by Jack Rude (rude@foo.com) who said:
I'm saying something abusive

The original comment can be found at:
http://dev.planningalerts.org.au/applications/2#comment23

To edit/hide/delete this comment:
http://dev.planningalerts.org.au/admin/comments/23/edit
    EOF
  end
end
