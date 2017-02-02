class NotificationsController < ApplicationController
  def create
    100.times do
      Sidekiq::Client.push(
        "queue" => "go_queue",
        "class" => "GoWorker",
        "args"  => [params]
      )
    end

    render json: {status: 'ok'}
  end
end
