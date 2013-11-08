# encoding: UTF-8
puts "Creating Conflict Minerals Due Diligence for Non-Filing Electronics Industry Manufacturers: Design and Implement A Strategy To Respond To Identified Risk ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('GSP'),
                               :full_name => 'Conflict Minerals Dodd-Frank Section 1502',
                               :display_name => 'Conflict Minerals',
                               :description => '',
                               :regulatory_review_name => 'Conflict Minerals Due Diligence for Non-Filing Electronics Industry Manufacturers: Design and Implement A Strategy To Respond To Identified Risk',
                               :frequency => 'Quarterly'.force_encoding('UTF-8'),
                               :objectives => "<p><strong>Objective:</strong> To evaluate and respond to identified risks in order to prevent or mitigate adverse impacts. Firms may cooperate to carry out the recommendations in this section through joint initiatives. However, firms retain individual responsibility for their due diligence, and should ensure that all joint work duly takes into consideration circumstances specific to the individual firm.<br />
<em>The recommended tasks do not constitute legal advice.&nbsp; Users should consult with their attorneys about their specific situation.</em></p>
".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "Establish communication process to report actual and potential risk to senior management",
:instructions => <<EOT
<ol start="1" style="list-style-type: decimal;">
	<li>Report findings of the most recent supply chain risk assessment in the review <em>Identify and Assess Risk in the Supply Chain </em>to the designated senior management of the company responsible for maintaining compliance with the Conflict Minerals Rule.

	<ol style="list-style-type:lower-alpha;">
		<li>Identify parameters, such as supplier response rates, timeliness, validation findings, percentage of supplier contracts with conflict minerals requirements, etc., that can be used as the basis for establishing quality assurance system.</li>
	</ol>
	</li>
	<li>Schedule follow-on quarterly meetings to update management on the status of suppliers&rsquo; ability to meet expectations set by their conflict minerals policies and your Firm&rsquo;s contract terms and conditions.​
	<ol start="1" style="list-style-type: lower-alpha;">
		<li>The meeting objective should be to determine whether identified supplier risks can be mitigated by continuing with the supplier committing to making the appropriate changes in its sourcing programs, suspending or terminating the relationship.
		<ul>
			<li>Ideally, all supplier products and components should be able to be traced back to Conflict Free Smelters as reported at&nbsp;<a href="http://www.conflictfreesmelter.org/">www.conflictfreesmelter.org</a>.</li>
		</ul>
		</li>
		<li>Management should be updated on legal developments and industry trends to determine of the Firm needs to make changes in its conflict minerals reporting program.</li>
	</ol>
	</li>
</ol>

EOT
}


template.tasks = tasks.to_json
template.save!
