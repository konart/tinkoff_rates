class RatesController < ApplicationController
  def index
    @avg = Rate.new.avg_pairs

    respond_to do |format|
      format.html
    end
  end

  def show
    render json: Rate.new.get_pair_by_action(params[:from], params[:to], params[:act].to_sym)
  end

end
