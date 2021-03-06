class MessagesController < ApplicationController
  before_action :set_message, only:[:show,:edit,:update,:destroy]

  def index
    #他のファイルでも使用する場合は、「@」のインスタンス変数を使用する 
    @messages = Message.order(created_at: :desc).all.page(params[:page]).per(10)
  end

  def show
  end

  def new
    #入力項目があるため、インスタンスを生成
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      flash[:success] = 'Message が正常に投稿されました'
      #redirect_to は実行後にshowを実行
      redirect_to @message
    else
      flash.now[:danger] = 'Message が投稿されませんでした'
      #renderは表示のみ
      render :new
    end
  end

  def edit
  end

  def update
    if @message.update(message_params)
      flash[:success] = 'Message は正常に更新されました'
      redirect_to @message
    else
      flash.now[:danger] = 'Message は更新されませんでした'
      render :edit
    end
  end

  def destroy
  end
  
  #このクラス内でのみ使用する
  private
  def set_message
    @message = Message.find(params[:id])  
  end

  #Strong parameter
  def message_params
    params.require(:message).permit(:content,:title)
  end
end


