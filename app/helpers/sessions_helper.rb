module SessionsHelper
	def log_in(user)
		session[:user_id] = user.id
	end

  def current_user
  	if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])#復号化するときもcookies.signed[:user_id]とする。cookiesのsignedは暗号化→復号化できる
      user = User.find_by(id: user_id)
	    if user && user.authenticated?(:remember, cookies[:remember_token])
	      log_in user
	      @current_user = user
	    end
    end
  end

  def current_user?(user)
  	user == current_user
  end

  def logged_in?
  	!current_user.nil?
  end

  def log_out #ログアウトしたらsessionとcookiesの情報を全て消す
  	forget(current_user)#二つのタブのうち一つでもログアウトしてしまうとcurrent_userが取れなくなるのでエラーが起こる
  	session.delete(:user_id)
  	@current_user = nil
  end



  def remember(user)
  	user.remember
  	cookies.permanent.signed[:user_id] = user.id #署名付きcookiesで見え見えのcookieをブラウザに保存する前に完全に暗号化。 ＋ permanentで有効期限を設定。
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
  	user.forget
  	cookies.delete(:user_id)
  	cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
	   redirect_to(session[:location_before] || default)
	   session.delete(:location_before)
  end

  def store_location
  	session[:location_before] = request.original_url if request.get?
  end
end

#session ログイン状態にする(current_userを取れるようにする)ブラウザ落ちたらなくなる
#cookies ログイン状態を長く保持する。                     ブラウザ落ちても保持
