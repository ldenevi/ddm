# encoding: UTF-8
puts "Creating Conflict Minerals Due Diligence for Auto Industry Manufacturers: Design and Implement A Strategy To Respond To Identified Risk ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('GSP'),
                               :full_name => 'Conflict Minerals, Dodd-Frank Section 1502',
                               :display_name => 'Conflict Minerals',
                               :description => '',
                               :regulatory_review_name => 'Conflict Minerals Due Diligence for Auto Industry Manufacturers: Design and Implement A Strategy To Respond To Identified Risk',
                               :frequency => 'Annual'.force_encoding('UTF-8'),
                               :objectives => "<p><strong>Objective:</strong> To evaluate and respond to identified risks in order to prevent or mitigate adverse impacts. Firms may cooperate to carry out the recommendations in this section through joint initiatives. However, firms retain individual responsibility for their due diligence, and should ensure that all joint work duly takes into consideration circumstances specific to the individual firm.<br />
<em>The recommended tasks do not constitute legal advice.&nbsp; Users should consult with their attorneys about their specific situation.</em></p>
".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "Establish communication process to report actual and potential risk to senior management",
:instructions => <<EOT
<ol>
	<li>Report findings of the most recent supply chain risk assessment in the review <em>Identify and Assess Risk in the Supply Chain </em>to the designated senior management of the company responsible for maintaining compliance with the Conflict Minerals Rule.</li>
	<li>Schedule follow-on quarterly meetings to update management on the status of suppliers&rsquo; ability to meet expectations set by their conflict minerals policies and your firm&rsquo;s contract terms and conditions.
	<ol style="list-style-type:lower-alpha;">
		<li>The meeting objective should be to determine whether identified supplier risks can be mitigated by continuing with the supplier committing to making the appropriate changes in its sourcing programs, suspending or terminating the relationship.</li>
	</ol>
	</li>
</ol>

<ul style="margin-left: 40px;">
	<li>Ideally, all supplier products and components should be able to be traced back to Conflict Free Smelters as reported at <a href="http://www.conflictfreesmelter.org/">www.conflictfreesmelter.org</a>.&nbsp;</li>
</ul>

EOT
}

tasks << {
:name => "Compare supplier results with IMDS data",
:instructions => <<EOT
<ol>
	<li>Ensure that the list of supplier materials, products, and components that are currently identified as an outcome of the task, <em>Determine scope of which products and components are applicable</em>, in the review, <em>Establish Strong Company Management Systems</em>, is current.</li>
	<li>List all materials, products and components that your firm identified as possibly containing conflict minerals that their suppliers did not include in their RCIO reports.</li>
	<li>Access IMDS (International Material Data System), <a href="http://www.mdsystem.com/">http://www.mdsystem.com/</a><a href="http://www.mdsystem.com">.</a></li>
	<li>Search IMDS for the composition of the supplier products that were suspected of containing conflict minerals by your firm but not reported as such. &nbsp;Verify that suppliers who reported to your firm that these materials, products or components did not include conflict minerals also made the same declaration when entering composition information into IMDS (Note that IMDS does not include country of origin data &ndash; only part composition data.)
	<ol style="list-style-type:lower-alpha;">
		<li>If there are any exceptions, immediately contact the supplier for clarification.</li>
	</ol>
	</li>
</ol>

<ul style="margin-left: 40px;">
	<li>If the supplier&rsquo;s explanation is inadequate, document the risk, inform the Conflict Minerals Oversight Reporting Committee and include this risk as an agenda item for senior management in Task 1 above until resolved.&nbsp;</li>
</ul>

EOT
}


template.tasks = tasks.to_json
template.save!
