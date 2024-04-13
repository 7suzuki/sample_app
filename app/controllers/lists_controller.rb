class ListsController < ApplicationController
 def new
  # Viewへ渡すためのインスタンス変数にからのModelオブジェクトを生成する
  @list = List.new
 end
 
 def create
  # 1&2 データを受取新規登録するためのインスタンス作成
  @list = List.new(list_params)
  # 3　データをデータベースに保存するためのsaveメソッド実行
  if @list.save
    # フラッシュメッセージを定義
    flash[:notice] = "投稿に成功しました。"
    # 詳細画面へリダイレクト
    redirect_to list_path(@list.id)
  else
    # flash.nowでフラッシュメッセージを定義
    flash.now[:alert] = "投稿に失敗しました。"
    
    #if-else-renderで投稿機能の入力を必須にする
    render :new
  end
  
 end
 
 def index
   @lists = List.all
 end
 
 def show
   @list = List.find(params[:id])
 end
 
 def edit
   @list = List.find(params[:id])
 end
 
 def update
   list = List.find(params[:id])
   list.update(list_params)
   redirect_to list_path(list.id)
 end
 
 def destroy
   list = List.find(params[:id]) #データ1件取得
   list.destroy #データを削除
   redirect_to '/lists' #投稿画面一覧へリダイレクト
 end
 
 private
# ストロングパラメータ＝脆弱性対策
  def list_params
    # require=モデル名指定 permit＝保存を許可するからむ
    params.require(:list).permit(:title, :body, :image)
  end
end
