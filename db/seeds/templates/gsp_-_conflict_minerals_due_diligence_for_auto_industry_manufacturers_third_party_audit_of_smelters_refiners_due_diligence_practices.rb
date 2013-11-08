# encoding: UTF-8
puts "Creating Conflict Minerals Due Diligence for Auto Industry Manufacturers: Third Party Audit of Smelters/Refiners Due Diligence Practices ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('GSP'),
                               :full_name => 'Conflict Minerals, Dodd-Frank Section 1502',
                               :display_name => 'Conflict Minerals',
                               :description => '',
                               :regulatory_review_name => 'Conflict Minerals Due Diligence for Auto Industry Manufacturers: Third Party Audit of Smelters/Refiners Due Diligence Practices',
                               :frequency => 'Annual'.force_encoding('UTF-8'),
                               :objectives => "<p><strong>Objective:</strong> To carry out an independent third-party audit of the smelter/refiner&rsquo;s due diligence for responsible supply chains of minerals from conflict-affected and high-risk areas and contribute to the improvement of smelter/refinery and upstream due diligence practices, including through any institutionalized mechanism to be established at the industry&rsquo;s initiative, supported by governments and in cooperation with relevant stakeholders.<br />
<em>The recommended tasks do not constitute legal advice.&nbsp; Users should consult with their attorneys about their specific situation.</em></p>
".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "Utilize conflict free smelter website",
:instructions => <<EOT
<ol>
	<li>List the smelters/refineries that your firm is able to identify as sources of the gold, tin, tantalum and tungsten in the products it manufactures based upon its Reasonable Country of Origin Inquiry and supply chain mapping efforts.</li>
	<li>Go to <a href="http://www.conflictfreesmelter.org/">http://www.conflictfreesmelter.org</a> and document which of the smelters/refiners identified in the firm&rsquo;s supply chain have been audited by the Conflict-Free Smelter Program and certified as compliant.</li>
	<li>E-mail the appropriate executive at each of the remaining smelters/refiners from which your firm does not directly buy conflict minerals with a request for its Conflict Free Policy and the report of the non-government organization (NGO) that audited it to confirm that it is sourcing its minerals from geographies outside the DRC and its adjoining countries.&nbsp; (Note that your firm has performed this task for smelters/refineries from which it directly acquires conflict minerals as part of its RCOI.)
	<ol style="list-style-type:lower-alpha;">
		<li>Document the results on this inquiry.</li>
	</ol>
	</li>
</ol>

<p>&nbsp;</p>

EOT
}


template.tasks = tasks.to_json
template.save!
