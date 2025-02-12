class ArticlesController < ApplicationController
    # Find the article to display for the show, edit, update and destroy actions
    before_action :find_article, only: [:show, :edit, :update, :destroy]
    
    # Display all articles in ascending order
    def index
        @articles = Articles.all
        if params[:query].present?
            @articles = Articles.search(params[:query])  # Search for articles based on the query
        else
            @articles = Articles.order(title: :asc)  # Display all articles in ascending order
        end
    end

    # Display a single article
    def show
        # Using before_action to find the article so no logic is needed here
    end

    # Create a new article
    def new
        @article = Articles.new
    end

    # Create a new article based on the form data
    def create
        @article = Articles.new(article_params)
        
        # Try to save the article
        if @article.save
            redirect_to @article, notice: 'Article was created successfully'  # Redirect to the article's page
        else
            render 'new'  # Render the new article form again
        end
    end

    # Edit an existing article
    def edit
        # Using before_action to find the article so no logic is needed here
    end

    # Update an existing article based on the form data
    def update
        # Try to update the article
        if @article.update(article_params)
            redirect_to @article, notice: 'Article was updated successfully'  # Redirect to the article's page
        else
            render 'edit'  # Render the edit article form again
        end
    end

    # Delete an existing article
    def destroy
        @article.destroy
        redirect_to root_path, notice: 'Article was deleted successfully'  # Redirect to the articles page
    end

    private

    # Define the parameters that can be passed to the article
    def article_params
        params.require(:article).permit(:title, :content, :author, :date)
    end

    # Find the article to display
    def find_article
        @article = Articles.find(params[:id])
    end
end