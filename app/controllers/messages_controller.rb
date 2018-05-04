class MessagesController < ApplicationController

  def index
    #他のファイルでも使用する場合は、「@」のインスタンス変数を使用する 
    @messages = Message.all
  end

  def show
     @message = Message.find(params[:id])
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
    @message = Message.find(params[:id])
  end

  def update
    @message = Message.find(params[:id])

    if @message.update(message_params)
      flash[:success] = 'Message は正常に更新されました'
      redirect_to @message
    else
      flash.now[:danger] = 'Message は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    flash[:success] = 'Message は正常に削除されました'
    redirect_to messages_url
  end
  
  #このクラス内でのみ使用する
  private
  #Strong parameter
  def message_params
    params.require(:message).permit(:content)
  end
end
