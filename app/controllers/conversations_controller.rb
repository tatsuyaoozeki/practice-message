class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.all
  end

  def create
    if signed_in
      if Conversation.between(params[:send_id], params[:recipient_id]).present?
        @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
      else
        @conversation = Conversation.create!(conversation_params)
      end
      redirect_to conversation_message_path(@conversation)
    else
      redirect_to root_path
    end
  end

  private

  def conversation_params
    params.permit(:send_id, :recipient_id)
  end
end
