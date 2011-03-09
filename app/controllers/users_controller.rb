#---
# Excerpted from "Agile Web Development with Rails, 3rd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails3 for more book information.
#---
class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
#START_HIGHLIGHT
    @users = User.find(:all, :order => :name)
#END_HIGHLIGHT

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
#START_HIGHLIGHT
        flash[:notice] = "ユーザ#{@user.name}が作成されました"
        format.html { redirect_to(:action=>'index') }
#END_HIGHLIGHT
        format.xml  { render :xml => @user, :status => :created,
                             :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors,
                             :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
#START_HIGHLIGHT
        flash[:notice] = "ユーザ#{@user.name}が更新されました"
        format.html { redirect_to(:action=>'index') }
#END_HIGHLIGHT
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors,
                             :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  #START:delete_user
  def destroy
    @user = User.find(params[:id])
    #START_HIGHLIGHT
    begin
      flash[:notice] = "ユーザ#{@user.name}は削除されました"
      @user.destroy
    rescue Exception => e
      flash[:notice] = e.message
    end
    #END_HIGHLIGHT

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  #END:delete_user
  end
end