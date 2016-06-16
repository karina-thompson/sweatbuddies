helpers do

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def alert_message
    return '' if flash(:flash).empty?
    messages = flash(:flash).map {|message| "  <div class='alert alert-#{message[0]}'>#{message[1]}</div>\n"}

    html = <<-HTML
      <div id="flash container">
        <div class="row col-md-6 col-md-offset-3">
          #{messages.join}
        </div>
      </div>
    HTML
    html
  end

  def profile_errors(user)
    messages = ''
    user.errors.full_messages.each do |message|
      messages += "<p>#{message}</p>"
    end
    flash[:warning] = messages  
  end

  def interests_list(interests)
    html = ''
    interests.each_with_index do |interest, index|
      html += %Q{<span>#{interest.name}</span>}
      html += ', ' unless index == (interests.length - 1)
    end
    html
  end

end