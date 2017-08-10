class DosesController < ApplicationController
  before_action :set_cocktail, only: [:new, :create, :destroy]
  def new
    @dose = Dose.new
  end

  def create
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    if dose.save
      redirect_to (cocktail_path(@cocktail))
    else
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to cocktails_path
  end
private



def set_cocktail
  @cocktail = Cocktail.find(params[:id])
end

def dose_params
  params.require.(:dose).permit(:description)
  end

end
