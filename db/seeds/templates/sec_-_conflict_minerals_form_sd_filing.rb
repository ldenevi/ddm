# encoding: UTF-8
puts "Creating Conflict Minerals Form SD Filing ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('SEC'),
                               :full_name => '[OLD] Conflict Minerals, Section 1502 of the Dodd-Frank Wall Street Reform and Consumer Protection Act',
                               :display_name => 'Conflict Minerals',
                               :description => 'Section 1502 of the Dodd-Frank Act requires public companies to provide disclosures relating to Conflict Minerals (gold, tin, tantalum, and tungsten) used in the products they manufacture.  The intent of the Dodd-Frank mandate is to curb violence and human rights abuses in the Democratic Republic of the Congo (the “DRC”) and its adjoining countries (collectively, the “Covered Countries”) that may be fueled by proceeds from trade in these minerals through required disclosure, consumer transparency and public pressure on companies that source Conflict Minerals from the region.',
                               :regulatory_review_name => 'Conflict Minerals Form SD Filing',
                               :frequency => 'Annual'.force_encoding('UTF-8'),
                               :objectives => "<p>Determine If the Firm Is Required To File Form SD.</p>
".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "Form SD Filing Confirmation",
:instructions => <<EOT
<p>Form SD Filing Confirmation</p><p>The following questions will determine if it is necessary to file Form SD.</p><ol><li>Does the firm file reports with the SEC under Sections 13(a) or 15(d) of the Exchange Act?<ol style="list-style-type:lower-alpha;"><li>If “NO,” the Conflict Minerals Rule does not apply.&nbsp; Document and close out this review.</li><li>If “YES,” CONTINUE.</li></ol></li><li>Does the firm/issuer manufacture or contract to manufacture products?&nbsp;<p style="margin-left:.5in;"><strong><em>Contract to Manufactur</em></strong><strong><em>e Definition</em></strong></p><p style="margin-left:.5in;"><em>An issuer’s determination of whether it “contracts to manufacture” will focus on the degree of influence the issuer exercises over the product’s manufacturing, including the materials, parts, ingredients, or components.&nbsp; If an issuer specifies that a particular conflict mineral be included in a product, this would be sufficient to be deemed “contract to manufacture.”&nbsp;</em></p><ol start="1" style="list-style-type: lower-alpha;"><li>If “NO,” the Conflict Minerals Rule does not apply. &nbsp;Document and close out the review.&nbsp;&nbsp;</li><li>If “YES,” CONTINUE.</li></ol></li><li>Are conflict minerals (gold,tantalum,&nbsp;tin, and/or&nbsp;tungsten) necessary to the functionality or production of the product manufactured or contracted to manufacture?<ol style="list-style-type:lower-alpha;"><li>If “NO,” the Conflict Minerals Rule does not apply.&nbsp; &nbsp;Document and close out the review.</li><li>If “YES,” CONTINUE.</li></ol></li><li>Were the conflict minerals the firm used in the last 12 months outside the supply chain prior to January 31, 2013?<ol style="list-style-type:lower-alpha;"><li>If “YES,”&nbsp;the Conflict Minerals Rule does not apply.&nbsp;&nbsp;Document and close out the review.</li><li>If “NO,” you will be requird to&nbsp;file Form SD before May 31st.&nbsp;</li></ol></li></ol>

EOT
}


template.tasks = tasks.to_json
template.save!
