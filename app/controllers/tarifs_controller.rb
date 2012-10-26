# encoding: utf-8

class TarifsController < ApplicationController

  layout "standard"
  before_filter :check, :except => ['index', 'new', 'create']

  def check
    unless Tarif.find(:first, :conditions =>  [" id = ? AND mairie_id = ?", params[:id], session[:mairie]])
       redirect_to :action => 'index'
    end
  end

  # GET /tarifs
  # GET /tarifs.xml
  def index
    @tarifs = Tarif.find_all_by_mairie_id(session[:mairie], :order => "memo")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tarifs }
    end
  end

  # GET /tarifs/1
  # GET /tarifs/1.xml
  def show
    @tarif = Tarif.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tarif }
    end
  end

  # GET /tarifs/new
  # GET /tarifs/new.xml
  def new
    @tarif = Tarif.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tarif }
    end
  end

  # GET /tarifs/1/edit
  def edit
    @tarif = Tarif.find(params[:id])
  end

  # POST /tarifs
  # POST /tarifs.xml
  def create
    @tarif = Tarif.new(params[:tarif])
    @tarif.mairie_id = session[:mairie]

    respond_to do |format|
      if @tarif.save
        flash[:notice] = ''
        format.html { redirect_to(tarifs_url) }
        format.xml  { render :xml => @tarif, :status => :created, :location => @tarif }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tarif.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tarifs/1
  # PUT /tarifs/1.xml
  def update
    @tarif = Tarif.find(params[:id])

    respond_to do |format|
      if @tarif.update_attributes(params[:tarif])
        flash[:notice] = 'Tarifs modifiés.'
        format.html { redirect_to(tarifs_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tarif.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tarifs/1
  # DELETE /tarifs/1.xml
  def destroy
    @tarif = Tarif.find(params[:id])
    @tarif.destroy

    respond_to do |format|
      format.html { redirect_to(tarifs_url) }
      format.xml  { head :ok }
    end
  end
  
end
