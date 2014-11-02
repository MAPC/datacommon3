class LayersController < ApplicationController
  before_filter :load_institution

  def index
    @layers = Layer.all.page params[:page] #institution(@institution)
  end

  def show
    @layer  = Layer.find_by(tablename: params[:id])
  end

  def meta_download
    @layer = Layer.find_by(tablename: params[:id])
    filename = "#{@layer.tablename}_metadata.#{params[:format]}"
    # disposition: attachment, defaults to using x-sendfile
    respond_to do |format|
      format.csv  { send_data @layer.to_csv,  filename: filename}
      format.json { send_data @layer.to_json, filename: filename}
      format.xml  { send_data @layer.to_xml,  filename: filename}
      format.yaml { send_data @layer.to_yaml, filename: filename}
    end
  end

  def download
    @layer = Layer.find_by(tablename: params[:id])
    filename = "#{@layer.tablename}.#{params[:format]}"

    respond_to do |format|
      format.csv  { redirect_to "http://files.dev.datacommon.org.s3-website-us-east-1.amazonaws.com/layers/downloads/#{params[:id]}.csv" }
      format.json { redirect_to "http://files.dev.datacommon.org.s3-website-us-east-1.amazonaws.com/layers/downloads/#{params[:id]}.json" }
    end
  end

end
