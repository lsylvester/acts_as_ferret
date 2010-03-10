$LOAD_PATH.unshift(File.join(Rails.root, '../../lib'))

require 'acts_as_ferret'

Rails.application.config.after_initialize { ActsAsFerret::load_config }
Rails.application.config.to_prepare       { ActsAsFerret::load_config }

ActsAsFerret::remote = false if ENV['AAF_REMOTE'] != 'true'
ActsAsFerret::raise_drb_errors = ENV['RAISE_DRB_ERRORS'] == 'true'

# define the index shared by the SharedIndex1 and SharedIndex2 classes
ActsAsFerret::define_index 'shared', :remote           => ENV['AAF_REMOTE'] == 'true',
                                     :raise_drb_errors => ENV['RAISE_DRB_ERRORS'] == 'true',
                                     :fields           => {
                                       :name => { :store => :yes }
                                     }, 
                                     :ferret           => {
                                       :default_field => [ :name ]
                                     }