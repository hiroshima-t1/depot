#---
# Excerpted from "Agile Web Development with Rails, 3rd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails3 for more book information.
#---
class AdminController < ApplicationController

  # フォームを単に表示して
  # ユーザが名前とパスワードを入力するのを待つ
  #START:login
  def login
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to(:action => "index")
      else
        flash.now[:notice] = "無効なユーザ／パスワードの組み合わせです"
      end
    end
  end
  #END:login

  #START:logout
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウト"
    redirect_to(:action => "login")
  end
  #END:logout

  #START:index
  def index
    @total_orders = Order.count
  end
  #END:index
end