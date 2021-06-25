class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :update, :destroy]

  def index
    @recipes = Recipe.all
    render json: { recipes: @recipes}
  end

  def show
    @recipe = Recipe.find(params[:id])
    json_data = {
        'id': @recipe.id,
        'title': @recipe.title,
        'making_time': @recipe.making_time,
        'serves': @recipe.serves,
        'ingredients': @recipe.ingredients,
        'cost': @recipe.ingredients,
        'created_at': @recipe.created_at,
        'updated_at': @recipe.updated_at
    }
    render json: { message: 'Recipe details by id', recipe: json_data}
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      json_data = {
        'id': @recipe.id,
        'title': @recipe.title,
        'making_time': @recipe.making_time,
        'serves': @recipe.serves,
        'ingredients': @recipe.ingredients,
        'cost': @recipe.ingredients
      }
      render json: { message: "Recipe successfully created !", data: json_data}
    else
      render json: {
        "message": "Recipe creation failed!",
        "required": @recipe.errors
       }
    end
  end

  def destroy
    @recipe.destroy
    if @recipe.destroy
      render json: { message: "Recipe successfully removed!" }
    else
      render json: { message: "No Recipe found" }
    end
  end

  def update
    if @recipe.update(recipe_params)
      json_data = {
        'id': @recipe.id,
        'title': @recipe.title,
        'making_time': @recipe.making_time,
        'serves': @recipe.serves,
        'ingredients': @recipe.ingredients,
        'cost': @recipe.ingredients
      }
      render json: { message: "Recipe successfully updated !", data: json_data}
    else
      render json: {
        "message": "Recipe update failed!",
        "required": @recipe.errors
       }
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :making_time, :serves, :ingredients, :costs)
  end

end
