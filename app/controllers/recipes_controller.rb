class RecipesController < ApplicationController
  protect_from_forgery
  before_action :set_recipe, only: [:show, :update, :destroy]

  def top
    render status: 404, json: { message: 'Page not found'}
  end

  def index
    @recipes = Recipe.all
    @arr = []
    @recipes.each do |recipe|
      json_data = {
        'id': recipe.id,
        'title': recipe.title,
        'making_time': recipe.making_time,
        'serves': recipe.serves,
        'ingredients': recipe.ingredients,
        'cost': recipe.cost
      }
      @arr.push(json_data)
    end
    render json: { recipes: @arr }
  end

  def show
    @recipe = Recipe.find(params[:id])
    json_data = [{
        'id': @recipe.id,
        'title': @recipe.title,
        'making_time': @recipe.making_time,
        'serves': @recipe.serves,
        'ingredients': @recipe.ingredients,
        'cost': @recipe.cost
    }]
    render json: { message: 'Recipe details by id', recipe: json_data}
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      json_data = [{
        'id': @recipe.id,
        'title': @recipe.title,
        'making_time': @recipe.making_time,
        'serves': @recipe.serves,
        'ingredients': @recipe.ingredients,
        'cost': @recipe.cost,
        'created_at': @recipe.created_at.strftime("%Y-%m-%d %H:%M:%S"),
        'updated_at': @recipe.updated_at.strftime("%Y-%m-%d %H:%M:%S")
      }]
      render json: { message: "Recipe successfully created!", recipe: json_data}
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
        'cost': @recipe.cost
      }
      render json: { message: "Recipe successfully updated!", data: json_data}
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
    params.require(:recipe).permit(:id, :title, :making_time, :serves, :ingredients, :cost, :created_at, :updated_at)
  end
end
