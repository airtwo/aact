require 'rails_helper'

RSpec.describe CalculatedValue, type: :model do
    it 'should have expected dates and calculated values' do
      nct_id='NCT00482794'
      xml=Nokogiri::XML(File.read("spec/support/xml_data/#{nct_id}.xml"))
      study=Study.new({xml: xml, nct_id: nct_id}).create

      expect(study.calculated_value.nct_id).to eq(nct_id)
      expect(study.first_received_date).to eq('June 1, 2007'.to_date)
      expect(study.last_changed_date).to eq('October 23, 2015'.to_date)
      expect(study.start_month_year).to eq('June 2006')
      expect(study.verification_month_year).to eq('October 2015')
      expect(study.primary_completion_month_year).to eq('July 2016')
      expect(study.completion_month_year).to eq('July 2016')
      expect(study.nlm_download_date_description).to eq('ClinicalTrials.gov processed this data on June 27, 2016')

      expect(study.calculated_value.start_date).to eq('June 2006'.to_date)
      expect(study.calculated_value.verification_date).to eq('October 2015'.to_date)
      expect(study.calculated_value.completion_date).to eq('July 2016'.to_date)
      expect(study.calculated_value.primary_completion_date).to eq('July 2016'.to_date)
      expect(study.calculated_value.nlm_download_date).to eq('June 27, 2016'.to_date)
      expect(study.calculated_value.were_results_reported).to eq(true)
      expect(study.minimum_age).to eq('N/A')
      expect(study.maximum_age).to eq('N/A')
      expect(study.calculated_value.has_minimum_age).to eq(false)
      expect(study.calculated_value.has_maximum_age).to eq(false)
      expect(study.calculated_value.minimum_age_num).to eq(nil)
      expect(study.calculated_value.maximum_age_num).to eq(nil)
      expect(study.calculated_value.minimum_age_unit).to eq('N/A')
      expect(study.calculated_value.maximum_age_unit).to eq('N/A')
    end

    it 'should have expected age info' do
      nct_id='NCT02586688'
      xml=Nokogiri::XML(File.read("spec/support/xml_data/#{nct_id}.xml"))
      study=Study.new({xml: xml, nct_id: nct_id}).create
      expect(study.calculated_value.has_minimum_age).to eq(true)
      expect(study.calculated_value.has_maximum_age).to eq(true)
      expect(study.calculated_value.minimum_age_num).to eq(12)
      expect(study.calculated_value.maximum_age_num).to eq(21)
      expect(study.calculated_value.minimum_age_unit).to eq('Years')
      expect(study.calculated_value.maximum_age_unit).to eq('Years')
    end
end
