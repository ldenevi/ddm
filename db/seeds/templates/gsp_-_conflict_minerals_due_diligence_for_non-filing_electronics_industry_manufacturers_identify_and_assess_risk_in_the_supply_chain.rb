# encoding: UTF-8
puts "Creating Conflict Minerals Due Diligence for Non-Filing Electronics Industry Manufacturers: Identify and Assess Risk in the Supply Chain ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('GSP'),
                               :full_name => 'Conflict Minerals Dodd-Frank Section 1502',
                               :display_name => 'Conflict Minerals',
                               :description => '',
                               :regulatory_review_name => 'Conflict Minerals Due Diligence for Non-Filing Electronics Industry Manufacturers: Identify and Assess Risk in the Supply Chain',
                               :frequency => 'Annual'.force_encoding('UTF-8'),
                               :objectives => "<p><strong>Objective:</strong> To identify and assess risks on the circumstances of extraction, trading, handling and export of minerals from conflict-affected and high-risk areas.<br />
<em style=\"line-height: 1.6em;\">The recommended tasks do not constitute legal advice.&nbsp; Users should consult with their attorneys about their specific situation.</em></p>
".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "Identify suppliers for due diligence based on criteria established",
:instructions => <<EOT
<ol>
	<li>Based on the work effort in the review, <em>Establish Strong Company Management Systems</em>, create a database of suppliers and the materials, products, components your Firm purchases from them that have been identified as containing conflict minerals (tin, tungsten, tantalum or gold).
	<ol style="list-style-type:lower-alpha;">
		<li>Ensure that each supplier&rsquo;s corporate headquarters location is clearly identified with subsidiaries and satellite locations distinctly noted.</li>
	</ol>
	</li>
	<li>Ensure that your Firm has identified a conflict minerals reporting contact (spokesperson) for each supplier identified above as the outcome of task 4, <em>Create process for supplier questions</em>, in the review, <em>Establish Strong Company Management Systems.</em>
	<ol style="list-style-type:lower-alpha;">
		<li>Unless modified due to the results of this review&rsquo;s task 2, <em>Review supplier identification process</em>, this list of contacts will be the basis for your Firm&rsquo;s RCOI (Reasonable Country of Origin Inquiry) work effort.</li>
	</ol>
	</li>
	<li>Concisely and clearly document the process and results of instructions 1 and 2 above in order that they can be summarized for inclusion in the Firm&rsquo;s &ldquo;Conflict Minerals Report&rdquo; and may be made public on the internet and/or provided to downstream customers for strengthening customer relationships.</li>
</ol>

EOT
}

tasks << {
:name => "Conduct a company-wide RCOI to determine whether the conflict minerals originated in the DRC countries",
:instructions => <<EOT
<ol>
	<li>If you buy conflict minerals directly from a smelter or refinery, contact each of your Firm&rsquo;s supplier conflict minerals reporting contacts for each smelter/refinery and request: a) if the smelter/refinery has been categorized as a Conflict Free Smelter by the Conflict Free Smelter Program; b) a written declaration as to whether your Firm&rsquo;s purchases of conflict minerals have been &ldquo;DRC conflict free,&rdquo; &ldquo;DRC conflict undeterminable,&rdquo; or &ldquo;Not DRC conflict free&rdquo;; and c) a copy of the smelter/refiner&rsquo;s Conflict Free Policy.&nbsp;
	<ol style="list-style-type:lower-alpha;">
		<li>If the smelter/refiner has been designated as Conflict Free by the CFS Program, request the 3<sup>rd</sup> party audit report.</li>
		<li>If the smelter/refinery has <strong><em><u>not</u></em></strong> been designated as Conflict Free by the CFS Program, request a written statement signed by an executive officer stating why it has not been designated as conflict free by the CFS Program.</li>
		<li>Document the communication process and response in detail:
		<ul>
			<li>Person or program office contacted and date;</li>
			<li>Method of communications, i.e. email, phone, in-person meeting, web conference, etc.;</li>
			<li>Substance of each communications.</li>
		</ul>
		</li>
	</ol>
	</li>
	<li>For materials, products and components that your Firm purchases that contain conflict minerals, contact each supplier&rsquo;s conflict minerals reporting Lead or spokesperson and request the supplier&rsquo;s most recent RCOI report in the <a href="http://www.conflictfreesmelter.org/ConflictMineralsReportingTemplateDashboard.htm">EICC-GeSI Conflict Mineral Reporting Template</a> Declaration Statement. &nbsp;Highlight that your Firm&rsquo;s objective is to trace the conflict minerals supply chain back to the smelter/refinery.
	<ol style="list-style-type:lower-alpha;">
		<li>Document the communication process and response in detail.
		<ul>
			<li>Person or program office contacted and date;</li>
			<li>Method of communications, i.e. email, phone, in-person meeting, web conferencing, etc.;</li>
			<li>Substance of each communications..</li>
		</ul>
		</li>
	</ol>
	</li>
	<li>Review each supplier&rsquo;s RCOI report (which must be provide in either EiCC/GESI format) and, if the conflict materials originating smelter/refiner was not identified, make a determination if the report was conducted in good faith.&nbsp;
	<ol style="list-style-type:lower-alpha;">
		<li>Note that task 5, <em>Analyze RCOI data for inconsistency</em>, will be conducted in parallel with this task.&nbsp; The purpose of task 5 is to analyze suppliers&rsquo; RCOI data in greater detail.</li>
		<li>If you have any questions about a report, contact the supplier&rsquo;s conflict minerals reporting spokesperson, discuss your concerns and document the conversation. &nbsp;If appropriate, follow-up with written correspondence.</li>
	</ol>
	</li>
</ol>

EOT
}

tasks << {
:name => "Analyze supplier RCOI data for inconsistency",
:instructions => <<EOT
<ol>
	<li>Conduct this task in conjunction with obtaining the responses from your suppliers regarding your demand for their RCOI and due diligence reports.</li>
	<li>Starting with the supplier your Firm purchases the greatest dollar amount of materials, products and/or components that contain conflict minerals and working in descending order, analyze the following:
	<ol style="list-style-type:lower-alpha;">
		<li>If responses are incomplete or inconsistent, the supplier should be contacted and asked for missing or supplemental information.</li>
		<li>Review the metal content information provided against any records which indicate metals used by the supplier.&nbsp; Determine if the records support the supplier disclosure.</li>
		<li>Data submitted should be consistent with any internal or external sources of data, such as part specifications.</li>
		<li>Confirm supplier smelter claims. &nbsp;Smelter status information can be researched by comparing the information provided to the published EICC/GeSI Conflict Free Smelter (CFS) list, London Bullion Market Association (LBMA) Good Deliver lists or other smelter certification program list.</li>
		<li>Verify responses that indicate the source of conflict minerals is recycled or scrap materials by requiring suppliers to provide appropriate and accurate documentation.</li>
		<li>Compare the supplier&rsquo;s supply chain policy to the <em>OECD Due Diligence Guidance for Responsible Supply Chains, Annex II, Model Supply Chain Policy for a Responsible Global Supply Chain of Minerals from Conflict-Affected and High-Risk Areas</em> and determine if the supplier&rsquo;s policy is similar.&nbsp;
		<ul>
			<li>If it is not, identify and document the areas in which the policies differ.
			<ul>
				<li>Contact the supplier&rsquo;s conflict minerals reporting spokesperson, review the inconsistency and document the supplier&rsquo;s response.</li>
				<li>If the inconsistency could indicate a risk, report it to the Conflict Minerals Reporting Oversight Committee for monitoring.</li>
			</ul>
			</li>
		</ul>
		</li>
		<li>Compare the supplier&rsquo;s due diligence standards and processes with those recommended by the OECD determine if the supplier&rsquo;s standards and processes are similar.
		<ul>
			<li>If it is not, identify and document the areas in which the policies differ.
			<ul>
				<li>Contact the supplier&rsquo;s conflict minerals reporting spokesperson, review the inconsistency and document the supplier&rsquo;s response.</li>
				<li>If the inconsistency could indicate a risk, report it to the Conflict Minerals Reporting Oversight Committee for monitoring.</li>
			</ul>
			</li>
		</ul>
		</li>
	</ol>
	</li>
	<li>Identify situations in which multiple suppliers are providing your Firm with the same component.
	<ol style="list-style-type:lower-alpha;">
		<li>Test to determine if the component&rsquo;s conflict minerals are mapped back to the same smelter/refiner.
		<ul>
			<li>If they are not, contact each supplier&#39;s conflict minerals reporting spokesperson, review the inconsistency and document the supplier&rsquo;s response.
			<ul>
				<li>If the inconsistency indicates a risk, report it to the Conflict Minerals Reporting Oversight Committee for monitoring.</li>
			</ul>
			</li>
		</ul>
		</li>
	</ol>
	</li>
</ol>

<p>&nbsp;</p>

EOT
}

tasks << {
:name => "Prepare your Firm’s RCOI Report",
:instructions => <<EOT
<ol>
	<li>Based upon the consolidation of your suppliers&rsquo; RCOIs, create your Firm&rsquo;s draft RCOI report, including all identified source smelters/refineries, using the EICC-GeSI Conflict Mineral Reporting Template Declaration Statement format.&nbsp; (An excellent example of a properly completed RCOI report for 2012 using the EICC-GeSI Conflict Mineral Reporting Template Declaration Statement format is <a href="http://www.philips.com/shared/assets/company_profile/downloads/Philips-Conflict-Minerals-Declaration.pdf">Philips Conflict Minerals Declaration</a>.) Guidelines for Questions 1-6 are:
	<ol style="list-style-type:lower-alpha;">
		<li><strong>Question 1: Are any of the following metals necessary to the functionality or production of your company</strong><strong>&rsquo;s products that it manufactures or contracts to manufacture?</strong>
		<ul>
			<li>It is expected you will answer &ldquo;Yes&rdquo; to these questions if your product(s) contains any amount (even trace amounts) of the conflict minerals.</li>
			<li>If you answer &ldquo;No&rdquo; for any of the derivatives in this question, you must enter the specific reason in the comments section.&nbsp; Examples of specific &ldquo;No&rdquo; reasons:
			<ul>
				<li>The Firm&rsquo;s products do not contain, in any form, any of the conflict minerals listed;</li>
				<li>The product contains conflict minerals but they are not necessary for its functionality.&nbsp; (Note: this answer requires documentation, such as a statement that the conflict minerals are for used for decorative purposes only.);</li>
				<li>Conflict minerals are used in the production process only and the finished product does not contain any conflict minerals.</li>
			</ul>
			</li>
		</ul>
		</li>
	</ol>
	</li>
</ol>

<p style="margin-left: 80px;"><strong>b.</strong><strong>Question 2: Do the following metals (necessary to the functionality or production of your company</strong><strong>&rsquo;s products) originate from the DRC or adjoining countries?</strong></p>

<ul style="margin-left: 80px;">
	<li>If your Firm&rsquo;s products contain conflict minerals and you can answer &ldquo;No,&rdquo; your Firm must provide the names and locations of the smelters/refiners from which the conflict minerals were sourced. &nbsp;</li>
	<li>If your products contain conflict minerals but you cannot provide smelter/refinery-level information, you may answer &ldquo;uncertain or unknown.&rdquo;</li>
	<li>If your products contain conflict minerals and you know they originate from the DRC or adjoining countries, you must answer, &ldquo;Yes.&rdquo;</li>
</ul>

<p style="margin-left: 80px;"><strong>c.</strong><strong>Question 3: Do the following metals (necessary to the functionality or production of your company</strong><strong>&rsquo;s products) come from a recycler or scrap supplier?</strong></p>

<ul style="margin-left: 80px;">
	<li>If your Firm answers &ldquo;Yes,&rdquo; you must be able to provide proof these conflict minerals come from recycled or scrap sources. &nbsp;A brief description to support your &ldquo;Yes&rdquo; answer must be provided.</li>
</ul>

<p style="margin-left: 80px;"><strong>d.</strong><strong>Question 4: Have you received completed Conflict Minerals Reporting Templates from all of your suppliers?</strong></p>

<ul style="margin-left: 80px;">
	<li>Provide the percentage of your Firm&rsquo;s suppliers that you contacted and the percentage that responded. &nbsp;For example: <em>The Firm contacted 100% of its suppliers of components that contain conflict minerals and received responses from 80% of those contacted.</em></li>
</ul>

<p style="margin-left: 80px;"><strong>e.</strong><strong>Question 5: For each of the following metals, have you identified all of the smelters your company and its suppliers use to supply the products included within the declaration scope above?</strong></p>

<ul style="margin-left: 80px;">
	<li>If your Firm answers &ldquo;Yes&rdquo;, you must list the names of the smelters for each metal in the &ldquo;EICC-GeSI Conflict Mineral Reporting Template Smelter List&rdquo; worksheet. &nbsp;Complete mine and smelter location addresses must be provided for any smelter that is not listed in the dropdown menus.</li>
</ul>

<p style="margin-left: 80px;"><strong>f.</strong><strong>Question 6: Have all of the smelters used by your company and its suppliers been validated as compliant in accordance with the Conflict-Free Smelter Program and listed on the Compliance Smelter List for the following metals?</strong></p>

<ul style="margin-left: 80px;">
	<li>If your Firm answers &ldquo;Yes,&rdquo; list the names of the smelters for each metal in the &ldquo;EICC-GeSI Conflict Mineral Reporting Template Smelter List&rdquo; worksheet.</li>
</ul>

<p style="margin-left: 80px;"><strong>g.</strong><strong>Answer the following Questions at a Company level</strong></p>

<ul style="margin-left: 80px;">
	<li>Provide an explanation expanding upon any &ldquo;No&rdquo; answer for questions A-J.&nbsp; If possible, for &ldquo;Yes&rdquo; answers provide links to supporting materials, such as the Firm&rsquo;s Conflict Minerals Policy.</li>
</ul>

<ol>
	<li value="2">Review the draft RCOI report with the Conflict Minerals Reporting Oversight Committee and make modifications as recommended.</li>
	<li value="3">Publish your RCOI report in both the EICC-GeSI Conflict Mineral Reporting Template Declaration Statement format, and, if you licensed a conflict minerals supply chain reporting tool, the reporting tool&rsquo;s format.</li>
	<li value="4">Concisely and clearly document the process and results of your work efforts in order that they can be summarized for inclusion in the &ldquo;Conflict Minerals Report&rdquo; written in a format similar to that required by filers for SEC Form SD. &nbsp;Note that even though your Firm is not a filer, it should be the Firm&rsquo;s policy to publish its &ldquo;Conflict Minerals Report&rdquo; on the internet and provided to downstream customers with the business objective of supporting its customers and enhancing its business reputation.</li>
</ol>

EOT
}

tasks << {
:name => "Conduct due diligence on the source and chain of custody of the conflict minerals using a recognized due diligence framework (OECD)",
:instructions => <<EOT
<ol>
	<li>Require that all your suppliers whose materials, products or component contain conflict minerals provide you with their Due Diligence Report based on the OECD (2013) report <a href="http://www.oecd.org/daf/inv/mne/GuidanceEdition2.pdf"><em>OECD Due Diligence Guidance for Responsible Supply Chains of Minerals from Conflict-Affected and High-Risk Areas</em></a><em>, Second Edition</em>. &nbsp;</li>
	<li>Review each supplier&rsquo;s Due Diligence Report to ensure that it is consistent with the OECD&rsquo;s five-step due diligence framework:
	<ol style="list-style-type:lower-alpha;">
		<li>Establish strong management systems</li>
		<li>Identify and assess risk in the supply chain</li>
		<li>Design and implement a strategy to respond to identified risks</li>
		<li>Third-party audit of smelters/refiners due diligence practices</li>
		<li>Report annually on supply chain due diligence</li>
	</ol>
	</li>
	<li>List all risks in the supply chain created by deficiencies in your suppliers&rsquo; due diligence. (Note that the OECD defines <em>due diligence</em> as &ldquo;an on-going, proactive and reactive process through which companies can ensure that they respect human rights and do not contribute to conflict.&rdquo;)</li>
	<li>Review the identified risks with the Conflict Minerals Reporting Oversight Committee.
	<ol style="list-style-type:lower-alpha;">
		<li>The objective should be to determine whether identified supplier risks can be mitigated by continuing with the supplier committing to making the appropriate changes in its due diligence process, suspending or terminating the relationship.</li>
		<li>All the Firm&rsquo;s suppliers&rsquo; due diligence processes must have the objective of ensuring that all conflict minerals can be traced back to Conflict Free Smelters as reported at <a href="http://www.conflictfreesmelter.org/">www.conflictfreesmelter.org</a>.</li>
	</ol>
	</li>
</ol>

<ol>
	<li value="5">Communicate the identified supplier due diligence risks and proposed Firm responses to senior management.</li>
</ol>

EOT
}

tasks << {
:name => "isclose description of RCOI and results in a format similar to that required for SEC Form SD",
:instructions => <<EOT
<ol>
	<li>Document if your Firm will disclose a description of RCOI and results in a format similar to that required for SEC Form SD.&nbsp; If not, explain why not.
	<ol style="list-style-type:lower-alpha;">
		<li>Best business practices dictate that non-filers should complete Form SD and make it available to their customers as soon as possible in order to remove themselves as a potential risk in their customers&rsquo; supply chain due diligence review.&nbsp;</li>
	</ol>
	</li>
	<li>Record what percentage of you Firm&rsquo;s suppliers were contacted, what percentage and number reported that their materials, products or components contained conflict minerals, and the percentage/number that appropriately provided the information your Firm required.</li>
	<li>If the conclusion of the RCOI was that the Firm&rsquo;s conflict minerals did <strong><em><u>not</u></em></strong> come from the DRC or adjoining countries, a non-filer should include in its Conflict Minerals Report:
	<ol style="list-style-type:lower-alpha;">
		<li>A heading entitled &ldquo;Conflict Minerals Disclosure.&rdquo;&nbsp; The first section should be a disclosure of how the Firm came to the conclusion that it did not use conflict minerals sourced from the DRC or adjoining countries.&nbsp;</li>
		<li>Briefly describe the RCOI process the Firm undertook in making this determination and the results of the inquiry it performed.</li>
		<li>Finally, the Firm should disclose this information on its publicly available Internet website and, under a separate heading in its specialized disclosure report entitled, &ldquo;Conflict Minerals Disclosure,&rdquo; provide a link to that website.</li>
	</ol>
	</li>
	<li>If the conclusion of the RCOI was that the Firm&rsquo;s conflict minerals did come from the DRC and/or adjoining countries, a non-filer Firm should:
	<ol style="list-style-type:lower-alpha;">
		<li>Include this conclusion in its Conflict Minerals Report and briefly describe the RCOI it undertook in making this determination and the results of the inquiry it performed.</li>
		<li>The Firm should disclose this information on its publicly available Internet website and, under a separate heading in its specialized disclosure report entitled &ldquo;Conflict Minerals Disclosure,&rdquo; provide a link to that website.</li>
	</ol>
	</li>
	<li>The Firm&rsquo;s, <em>Conflict Minerals Report</em>, should include the following information:</li>
</ol>

<p style="margin-left:1.0in;"><strong><em>Due Diligence</em></strong>: A description of the measures the Firm has taken to exercise due diligence on the source and chain of custody of those conflict minerals. (Note that the Firm will prepare its Due Diligence Report with the OECD step, <em>Report Annually on Supply Chain Due Diligence</em>.&nbsp; Also note that filers must include an independent private sector audit of their Due Diligence to ensure that it is in conformity with the criteria described by the OECD and that the description of the due diligence process they undertook is accurate.&nbsp; Non-filers are not expected to voluntarily conduct a due diligence audit but may be required to do so by their strategic customers.);</p>

<p style="margin-left:1.0in;"><strong><em>Product Description</em></strong>: For all the Firm&rsquo;s product that have <strong><em><u>not</u></em></strong> been found to be &ldquo;DRC conflict free&rdquo; or are temporarily categorized as &ldquo;DRC conflict undeterminable,&rdquo; the Firm should:</p>

<ul style="margin-left: 80px;">
	<li>Provide a description of the products;</li>
	<li>Identify the facilities used to process the necessary conflict minerals in those products, if known;</li>
	<li>The country of origin of the necessary conflict minerals in those products, if known;</li>
	<li>The Firm&rsquo;s efforts to determine the mine or location of origin with the greatest possible specificity.</li>
</ul>

<ol>
	<li value="6">Review the draft of the Conflict Minerals Disclosure and Conflict Minerals Report with the Conflict Minerals Reporting Oversight Committee and make modifications as recommended before publishing.</li>
</ol>

EOT
}

tasks << {
:name => "Identify resources to complete inquiry/analyze data",
:instructions => <<EOT
<ol>
	<li>Review your conflict minerals reporting work efforts in a meeting with a sampling of your strategic customers.
	<ol style="list-style-type:lower-alpha;">
		<li>Request recommendations for improving your Firm&rsquo;s reporting process for both the current and upcoming year.</li>
	</ol>
	</li>
</ol>

EOT
}

tasks << {
:name => "Respond to information requests from customers",
:instructions => <<EOT
<ol>
	<li>Proactively email your Firm&rsquo;s completed EICC-GeSI Conflict Minerals Reporting Declaration Statement and Due Diligence Report to your Firm&rsquo;s customers.</li>
	<li>Provide your Firm&rsquo;s completed EICC-GESI Conflict Minerals Reporting Declaration as link in the &ldquo;Conflict Minerals Disclosure&rdquo; page on your Firm&rsquo;s website.</li>
	<li>Maintain a log of customer inquiries (Customer Inquiry Log) addressed to the Firm&rsquo;s conflict minerals reporting spokesperson.
	<ol style="list-style-type:lower-alpha;">
		<li>Include contact information for the customer&rsquo;s representative making the inquiry, date of the inquiry, your Firm&rsquo;s spokesperson, a description of the response provide to the customer, an evaluation of the customer&rsquo;s satisfaction with the answer, if follow-up was required, and when the inquiry was closed.</li>
		<li>Ensure that all customer inquiries are responded to within 2 working days.</li>
		<li>Review the Customer Inquiry log with the Conflict Minerals Oversight Reporting Committee at each scheduled meeting.</li>
		<li>Review in depth any customer inquiries that remained open for more than five business days.</li>
	</ol>
	</li>
</ol>

<p>&nbsp;</p>

EOT
}


template.tasks = tasks.to_json
template.save!
