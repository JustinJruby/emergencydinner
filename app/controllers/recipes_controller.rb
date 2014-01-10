require "open-uri"

class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
#  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :sort]

# GET /recipes
# GET /recipes.json
  def index
    @recipes = Recipe.rank(:row_order).load
  end

  def index2
    @recipes = Recipe.rank(:row_order).load
  end

  def make_cover
    page_wdith = 1201
    pdf = Prawn::Document.new(:info => {"GTS_PDFXVersion" => "PDF/X-3:2002",
                                        :Trapped => :False,
                                        :CreationDate => Time.now,
                                        :ModDate => Time.now,
                                        :Title => "My Document"},
                              :page_size => [1201, 738],
                              :top_margin => 0, :bottom_margin => 0, :left_margin => 0, :right_margin => 0)

    gutter_width = 31

    start_of_gutter = ((page_wdith)/2)-(gutter_width/2)

    pdf.font "Helvetica"
    pdf.font_size = 13


    image = File.join(Dir.home, "boats.jpg")
    pdf.image image, :at => [-300, 800], :fit => [page_wdith, page_wdith]

    image = File.join(Dir.home, "pumkin.jpeg")
    pdf.image image, :at => [start_of_gutter, 750], :scale => 0.25
    image = File.join(Dir.home, "tuna.jpg")
    pdf.image image, :at => [start_of_gutter, 350], :scale => 0.25

    pdf.fill_color "FF0000"
    pdf.fill_rectangle [start_of_gutter, 738], gutter_width, 745


    pdf.fill_color "FF0000"
    pdf.fill_rectangle [start_of_gutter, 400], 650, 70

    pdf.formatted_text_box [:text => "Chateau Jay and Bisto Ains\n2013 Cookbook - Justin & Ainslie",
                            :align => :center, align: :center, valign: :center, :size => 30,
                            :color => GRAY, :style => :bold], :at => [700, 395]

    pdf.fill_color "000000"
    pdf.text_box "Chateau Jay & Bistro Ains (2013)", :at => [start_of_gutter+10, 257], :rotate => 90

    send_data pdf.render, type: "application/pdf", disposition: "inline"

  end

  def header_box(&block)
    bounding_box([-bounds.absolute_left, cursor + BOX_MARGIN],
                 :width => bounds.absolute_left + bounds.absolute_right,
                 :height => BOX_MARGIN*2 + RHYTHM*2) do

      fill_color LIGHT_GRAY
      fill_rectangle([bounds.left, bounds.top],
                     bounds.right,
                     bounds.top - bounds.bottom)
      fill_color BLACK

      indent(BOX_MARGIN + INNER_MARGIN, &block)
    end

    stroke_color GRAY
    stroke_horizontal_line(-BOX_MARGIN, bounds.width + BOX_MARGIN, :at => cursor)
    stroke_color BLACK

    move_down(RHYTHM*3)
  end

  BOX_MARGIN = 36

# Additional indentation to keep the line measure with a reasonable size
#
  INNER_MARGIN = 30

# Vertical Rhythm settings
#
  RHYTHM = 10
  LEADING = 2

# Colors
#
  WHITE = "FFFFFF"
  BLACK = "000000"
  LIGHT_GRAY = "F2F2F2"
  GRAY = "DDDDDD"
  DARK_GRAY = "333333"
  BROWN = "A4441C"
  ORANGE = "F28157"
  LIGHT_GOLD = "FBFBBE"
  DARK_GOLD = "EBE389"
  BLUE = "0000D0"


  def example_header(pdf, example)
    header_box(pdf) do

      pdf.font('Helvetica', :size => 24) do
        pdf.formatted_text([# { :text => package, :color => BROWN  },
                            # { :text => "/",     :color => BROWN  },
                               {:text => example, :color => ORANGE}
                           ], :valign => :center)
      end
    end
  end

  def header_box(pdf, &block)
    pdf.bounding_box([-pdf.bounds.absolute_left, pdf.cursor + BOX_MARGIN],
                     :width => pdf.bounds.absolute_left + pdf.bounds.absolute_right,
                     :height => BOX_MARGIN*2 + RHYTHM*2) do

      pdf.fill_color LIGHT_GRAY
      pdf.fill_rectangle([pdf.bounds.left, pdf.bounds.top],
                         pdf.bounds.right,
                         pdf.bounds.top - pdf.bounds.bottom)
      pdf.fill_color BLACK

      pdf.indent(BOX_MARGIN + INNER_MARGIN, &block)
    end

    pdf.stroke_color GRAY
    pdf.stroke_horizontal_line(-BOX_MARGIN, pdf.bounds.width + BOX_MARGIN, :at => pdf.cursor)
    pdf.stroke_color BLACK

    pdf.move_down(RHYTHM*3)
  end


  def make
    pdf = Prawn::Document.new(:info => {"GTS_PDFXVersion" => "PDF/X-3:2002",
                                        :Trapped => :False,
                                        :CreationDate => Time.now,
                                        :ModDate => Time.now,
                                        :Title => "My Document"},
                              :page_size => [585, 738],
                              :top_margin => 30,
                              :bottom_margin => 30,
                              :left_margin => 60,
                              :right_margin => 60
    )

    pdf.font "Helvetica"
    pdf.font_size = 13


    image = File.join(Dir.home, "pics", "DSCN0938.JPG")
    pdf.image image, :at => [-60, 405], :fit => [585, 808]

    pdf.formatted_text_box [:text => "For Ainslie And Justin\nAlways looking for a bite",
                            :align => :center, :size => 18,
                            :color => BLACK, :style => :bold],
                           :at => [-60, 600],
                           :width => 585, :height => 100, align: :center


    @recipes = Recipe.rank(:row_order).all
    @recipes = Recipe.where(:id => params[:id]).all unless params[:id].blank?
    @recipes = Recipe.where("pdf_eval is not null").all unless params[:overload].blank?

    @recipes.each do |recipe|
      next if recipe.title.titleize =='New'

      if (["AUTUM", "SPRING", "summer", "WINTER"].index(recipe.title)!=nil)
        pdf.start_new_page(:layout => :portrait)
        if (pdf.page_number % 2 == 0)
          pdf.start_new_page(:layout => :portrait)
        end
        example_header(pdf, recipe.title.titleize)
        if recipe.pdf_eval.blank? == false
          eval recipe.pdf_eval
        end

      else
        current_page = pdf.page_count
        make_recipe(pdf, recipe)
        if pdf.page_count == current_page+2 && pdf.page_count.even? == false
          puts "Bad Extend on :: #{recipe.title} #{pdf.page_count} #{current_page}"

        end
      end


    end


    pdf.start_new_page(:layout => :portrait)
    example_header(pdf, 'Safe Cooking Temperatures')
    pdf.text "\n"

    SafeCookingTemp.uniq.pluck(:meat_type).each do |type|
      pdf.text "<b>#{type}</b>", :inline_format => true
      SafeCookingTemp.where(:meat_type => type).load.each do |safe_cooking|
        pdf.text "\t\t\t  #{safe_cooking.temp} \t\t #{safe_cooking.note} \n"
      end
      pdf.text "\n"
    end

    pdf.start_new_page(:layout => :portrait)
    example_header(pdf, 'Notes')

    puts "Total: #{pdf.page_count}"
    if (pdf.page_count.odd?)
      pdf.start_new_page(:layout => :portrait)
      example_header(pdf, 'Notes')
    end

    send_data pdf.render, type: "application/pdf", disposition: "inline"
  end

  def make_recipe(pdf, recipe)
    pdf.start_new_page(:layout => :portrait)
    example_header(pdf, recipe.title.titleize)
    pdf.text "\n"
    updated_ingredient = recipe.ingredient
    pdf.text "<b>Ingredients</b>\n", :inline_format => true
    pdf.text updated_ingredient, :inline_format => true
    pdf.text "\n<b>Steps</b>\n", :inline_format => true
    pdf.text recipe.steps, :inline_format => true
    if recipe.pdf_eval.blank? == false
      eval recipe.pdf_eval
    end

  end

  def make_temp(pdf)
    pdf.start_new_page(:layout => :portrait)

    pdf.text "Cooking Temperatures", {:style => :bold, :size => 16}
    pdf.text "\n"

  end

  def sort
    @thing = Recipe.find(params[:id])

    @thing.row_order_position = params[:thing][:row_order_position]
    @thing.save

    # this action will be called via ajax
    render nothing: true
  end


  # GET /recipes/1
  # GET /recipes/1.json
  def show
  end

  def sub30
    @recipes = Recipe.tagged_with("sub30")
    render 'index'
  end

  def meaty
    @recipes = Recipe.tagged_with("meaty")
    render 'index'
  end

  def blown
    @recipes = Recipe.tagged_with("blown")
    render 'index'
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render action: 'show', status: :created, location: @recipe }
      else
        format.html { render action: 'new' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.where(slug: params[:id]).first
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def recipe_params
    params.require(:recipe).permit(:pdf_eval, :title, :link, :slug, :time, :ingredient, :pantry, :source, :time_note, :tag_list, :steps, :row_order)
  end
end
