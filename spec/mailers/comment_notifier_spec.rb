require 'spec_helper'

describe CommentNotifier do
  describe "notify" do
    before :each do
      authority = mock_model(Authority, :full_name => "Foo Council", :email => "foo@bar.gov.au")
      application = mock_model(Application, :authority => authority, :address => "12 Foo Rd", :council_reference => "X/001", :description => "Building something", :id => 123)
      @comment = mock_model(Comment, :email => "foo@bar.com", :name => "Matthew", :application => application, :confirm_id => "abcdef", :text => "A good thing")
    end
  
    it "should be sent to the planning authority's feedback email address" do
      notifier = CommentNotifier.notify(@comment)
      notifier.to.should == [@comment.application.authority.email]
    end
    
    it "should be from the email address of the person who made the comment" do
      notifier = CommentNotifier.notify(@comment)
      notifier.from.should == [@comment.email]
      #notifier.from_addrs.first.name.should == @comment.name
    end

    it "should say in the subject line it is a comment on a development application" do
      notifier = CommentNotifier.notify(@comment)
      notifier.subject.should == "Comment on application X/001"
    end
    
    it "should have specific information in the body of the email" do
      notifier = CommentNotifier.notify(@comment)
      notifier.body.should == <<-EOF
Application:          X/001
Address:              12 Foo Rd
Description:          Building something
Comment submitted by: Matthew
Email:                foo@bar.com

A good thing

=============================================================================
This comment was submitted via PlanningAlerts.org.au, a free service
run by the OpenAustralia Foundation for the public good.
See http://dev.planningalerts.org.au/applications/123 for more information

http://www.openaustraliafoundation.org.au
=============================================================================
      EOF
    end
  end
end