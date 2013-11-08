# encoding: UTF-8
puts "Creating Complete EICC-GeSI Conflict Mineral Reporting Template Declaration Statement ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('GSP'),
                               :full_name => 'Dodd-Frank Section 1502 -- Sec Conflict Mineral Rule',
                               :display_name => 'Conflict Minerals',
                               :description => '',
                               :regulatory_review_name => 'Complete EICC-GeSI Conflict Mineral Reporting Template Declaration Statement',
                               :frequency => 'Annual'.force_encoding('UTF-8'),
                               :objectives => "<p>Map the factual circumstances of the company&rsquo;s supply chain(s) to identify and assess risks on the circumstances of extraction, trading, handling and export of minerals from conflict-affected and high-risk areas.<br />
<em>The recommended tasks do not constitute legal advice. Users should consult with their attorneys about their specific situation.</em></p>
".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "Obtain Current Version of EICC-GeSI Conflict Minerals Reporting Template",
:instructions => <<EOT
<ol>
	<li>Go to <a href="http://www.conflictfreesmelter.org/ConflictMineralsReportingTemplateDashboard.htm"><u>http://www.conflictfreesmelter.org/ConflictMineralsReportingTemplateDashboard.htm</u></a> and download the most <strong>current version</strong> of the EICC-GeSI Conflict Minerals Reporting Template.</li>
	<li>Review all <strong>training materials</strong>, including videos and FAQs, provided on the website in instruction 1.</li>
	<li>Review the <strong>Revision</strong> sheet of the Reporting Template to identify updates from previous versions.</li>
	<li>Open the <strong>Instructions</strong> sheet of the Reporting Template and familiarize yourself with the requirements paying special attention to the mandatory fields.</li>
	<li>Please note that you must provide <strong>Comments in ENGLISH only</strong>.</li>
</ol>

<p><strong>Document</strong> your conformance to these instructions in the &ldquo;Add a comment&rdquo; box below.&nbsp; Note that when you click on the box a text editor will be displayed.&nbsp; The ability to attach files is provided at the bottom of the dialogue box.&nbsp; Click on Submit to preserve your documentation.</p>

EOT
}

tasks << {
:name => "Complete Company Information Questions (Rows 8-18)",
:instructions => <<EOT
<ol>
	<li><strong>Company Name</strong>: Insert your company&#39;s Legal Name.&nbsp; Please do not use abbreviations.<br />
	&nbsp;</li>
	<li><strong>Declaration Scope</strong>: Select your company&rsquo;s Declaration Scope. For Scope selections of &ldquo;Division&rdquo; or &ldquo;Category of Products&rdquo;, provide additional details describing company division or plant, or specific category of product(s) for which this Template is being completed in the &ldquo;Description of Scope&rdquo; field.&nbsp; For Scope selection of Product(s) a link to the worksheet tab for Product List will be displayed.</li>
</ol>

<p>&nbsp;</p>

<ol>
	<li value="3"><strong>Company Unique Identifier</strong>: Insert your company&rsquo;s unique identifier number or code (DUNS number, VAT number, etc)</li>
</ol>

<p>&nbsp;</p>

<ol>
	<li value="4"><strong>Address</strong>: Insert your full company address (street, city, state, country, postal code)</li>
</ol>

<p>&nbsp;</p>

<ol>
	<li value="5"><strong>Authorized Company Representative Name:</strong> Please identify the authorized management representative responsible for the accuracy of the data in this template.</li>
</ol>

<p>&nbsp;</p>

<ol>
	<li value="6"><strong>Representative Title</strong>: (Optional) Please provide the authorized management representative&rsquo;s company-designated title.</li>
</ol>

<p>&nbsp;</p>

<ol>
	<li value="7"><strong>Representative Email: </strong>Please provide the authorized management representative&rsquo;s company email.</li>
</ol>

<p>&nbsp;</p>

<ol>
	<li value="8"><strong>Date of Completion</strong>: Please enter the Date of Completion for this form using the format DD-MM-YYYY</li>
</ol>

<p>&nbsp;</p>

<ol>
	<li value="9"><strong>File Name</strong>: Save the file name as: companyname-date.xls (date as YYYY-MM-DD)</li>
</ol>

EOT
}

tasks << {
:name => "Complete Due Diligence Questions (Rows 21-51)",
:instructions => <<EOT
<p><strong>Question 1: Are any of the following metals necessary to the functionality or production of your company&#39;s products that it manufactures or contracts to manufacture? </strong></p>

<ul>
	<li>It is expected you will answer &ldquo;Yes&rdquo; to these questions if your product(s) contains any amount (even trace amounts) of the conflict minerals.
	<ul style="list-style-type: circle;">
		<li>If the answer provided for any metal listed is &ldquo;Yes&rdquo;, responses are required for Questions 2 through 6, as indicated by the yellow highlighted fields.</li>
	</ul>
	</li>
	<li>If you answer &ldquo;No&rdquo; for any of the derivatives in this question, you must enter the specific reason in the comments section.&nbsp; Examples of specific &ldquo;No&rdquo; reasons:
	<ul style="list-style-type: circle;">
		<li>The Firm&rsquo;s products do not contain, in any form, any of the conflict minerals listed;</li>
		<li>The product contains conflict minerals but they are not necessary for its functionality.&nbsp; (Note: this answer requires documentation, such as a statement that the conflict minerals are for used for decorative purposes only.);</li>
		<li>Conflict minerals are used in the production process only and the finished product does not contain any conflict minerals.</li>
	</ul>
	</li>
</ul>

<p>&nbsp;</p>

<ul style="list-style-type: circle;">
	<li>If the answer provided for any metal listed is &ldquo;No&rdquo;, all remaining fields within this section will be highlighted black, indicating that no further responses are required and your declaration is considered complete.</li>
</ul>

<p>&nbsp;</p>

<p><strong>Question 2: Do the following metals (necessary to the functionality or production of your company&rsquo;s products) originate from the DRC or adjoining countries?</strong></p>

<ul>
	<li>If your Firm&rsquo;s products contain conflict minerals and you can answer &ldquo;No,&rdquo; your Firm must provide the names and locations of the smelters/refiners from which the conflict minerals were sourced.</li>
	<li>If your products contain conflict minerals but you cannot provide smelter/refinery-level information, you may answer &ldquo;uncertain or unknown.&rdquo;</li>
	<li>If your products contain conflict minerals and you know they originate from the DRC or adjoining countries, you must answer, &ldquo;Yes.&rdquo;</li>
</ul>

<p>&nbsp;</p>

<p><strong>Question 3: Do the following metals (necessary to the functionality or production of your company&rsquo;s products) come from a recycler or scrap supplier?</strong></p>

<ul>
	<li>If your Firm answers &ldquo;Yes,&rdquo; you must be able to provide proof these conflict minerals come from recycled or scrap sources. &nbsp;A brief description to support your &ldquo;Yes&rdquo; answer must be provided.</li>
</ul>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p><strong>Question 4: Have you received completed Conflict Minerals Reporting Templates from all of your suppliers?</strong></p>

<ul>
	<li>Provide the percentage of your Firm&rsquo;s suppliers that you contacted and the percentage that responded. &nbsp;For example: The Firm contacted 100% of its suppliers of components that contain conflict minerals and received responses from 80% of those contacted.</li>
</ul>

<p>&nbsp;</p>

<p><strong>Question 5: For each of the following metals, have you identified all of the smelters your company and its suppliers use to supply the products included within the declaration scope above?</strong></p>

<ul>
	<li>If your Firm answers &ldquo;Yes&rdquo;, you must list the names of the smelters for each metal in the &ldquo;EICC-GeSI Conflict Mineral Reporting Template Smelter List&rdquo; worksheet. &nbsp;Complete mine and smelter location addresses must be provided for any smelter that is not listed in the dropdown menus.</li>
</ul>

<p>&nbsp;</p>

<p><strong>Question 6: Have all of the smelters used by your company and its suppliers been validated as compliant in accordance with the Conflict-Free Smelter Program and listed on the Compliance Smelter List for the following metals?</strong></p>

<ul>
	<li>If your Firm answers &ldquo;Yes,&rdquo; list the names of the smelters for each metal in the &ldquo;EICC-GeSI Conflict Mineral Reporting Template Smelter List&rdquo; worksheet.</li>
</ul>

EOT
}

tasks << {
:name => "Complete the Company-level Questions (Rows 29-77)",
:instructions => <<EOT
<p><strong>Answer the following Questions at a Company level:</strong></p>

<p>&nbsp;</p>

<p><strong>Question A. Do you have a policy in place that includes DRC conflict-free sourcing? </strong></p>

<ul>
	<li>Provide an explanation expanding upon any &ldquo;No&rdquo; answer in the Conflict Mineral Reporting Template Comments box.&nbsp; If possible, for &ldquo;Yes&rdquo; answer include supporting materials and/or provide links in the Conflict Mineral Reporting Template Comments box.</li>
</ul>

<p>&nbsp;</p>

<p><strong>Question B. Is this policy publicly available on your website?</strong></p>

<ul>
	<li>Provide an explanation expanding upon any &ldquo;No&rdquo; answer in the Conflict Mineral Reporting Template Comments box.&nbsp; If possible, for &ldquo;Yes&rdquo; answer include supporting materials and/or provide links in the Conflict Mineral Reporting Template Comments box.</li>
</ul>

<p><strong>Question C. Do you require your direct suppliers to be DRC conflict-free?</strong></p>

<p>Please answer &ldquo;Yes&rdquo; or &ldquo;No&rdquo;.&nbsp; Provide Comments with links to supporting documentation.</p>

<ul>
	<li>&ldquo;DRC conflict-free&rdquo; is defined in the US Dodd-Frank Wall Street Reform and Consumer Protection Act as &ldquo;products that do not contain conflict minerals that directly or indirectly finance or benefit armed groups in the Democratic Republic of the Congo or an adjoining country&rdquo;.</li>
</ul>

<p>&nbsp;</p>

<p><strong>Question D</strong>. <strong>Do you require your direct suppliers to source from smelters validated as compliant to a CFS protocol using the CFS Compliant Smelter List?</strong></p>

<p>Please answer &ldquo;Yes&rdquo; or &ldquo;No&rdquo;.&nbsp; Provide Comments to support your response.</p>

<ul>
	<li>The Conflict-Free Smelter (CFS) List is a list of mineral smelters and refiners who have been validated to be in compliance with the CFS program.&nbsp; For the current list and more information about the program please go to www.conflictfreesmelter.org.</li>
</ul>

<p>&nbsp;</p>

<p><strong>Question E. Have you implemented due diligence measures for conflict-free sourcing?&nbsp; </strong></p>

<p>Please answer &ldquo;Yes&rdquo; or &ldquo;No&rdquo;.&nbsp; Provide Comments to support your response.</p>

<p>&nbsp;</p>

<ul>
	<li>Examples of due diligence measures may include: communicating and incorporating into contracts (where possible) your expectations to suppliers on conflict-free mineral supply chain; identifying and assessing risks in the supply chain; designing and implementing a strategy to respond to identified risks; verifying your direct supplier&rsquo;s compliance to its DRC conflict-free policy, etc.&nbsp; These due diligence measure examples are consistent with the guidelines included in the internationally recognized OECD Guidance.</li>
</ul>

<p>&nbsp;</p>

<p><strong>Question F. Do you request your suppliers to fill out this Conflict Minerals Reporting Template?</strong></p>

<p>&nbsp;</p>

<p>Please answer &ldquo;Yes&rdquo; or &ldquo;No&rdquo;. &nbsp;If &ldquo;No&rdquo;, please describe what you request your suppliers to complete (e.g., certificate of compliance, custom form, none, etc.).</p>

<p>&nbsp;</p>

<p><strong>Question G. Do you request smelter names from your suppliers?</strong></p>

<p>Please answer &ldquo;Yes&rdquo; or &ldquo;No&rdquo;.&nbsp; Provide Comments to document your answer<strong>.</strong></p>

<p>&nbsp;</p>

<p><strong>Question H. Do you verify due diligence information received from your suppliers?</strong></p>

<p>Please select the best response which indicates if and how your company verifies the responses provided by your suppliers.&nbsp; &ldquo;Yes (3<sup>rd</sup> party audit); &ldquo;Yes&rdquo; (documentation review only); &ldquo;Yes (internal audit); &ldquo;Yes&rdquo; (all methods apply); or &ldquo;No.&rdquo;&nbsp; In the Comments box, state the basis for your response.</p>

<p>Please refer to the following definitions when responding:</p>

<ul>
	<li>&ldquo;3rd party audit&rdquo; refers to on-site audits of your suppliers conducted by independent third parties.</li>
	<li>&ldquo;Documentation review only&rdquo; refers to a review of supplier submitted records and documentation conducted by independent third parties and/or your company personnel.</li>
	<li>&ldquo;Internal audit&rdquo; refers to on-site audits of your suppliers conducted by your company personnel.</li>
</ul>

<p>&nbsp;</p>

<p><strong>Question I. Does your verification process include corrective action management?</strong></p>

<p>Please answer &ldquo;Yes&rdquo; or &ldquo;No&rdquo;.&nbsp; If &ldquo;Yes&rdquo;, please describe how you manage your corrective action process.</p>

<p>&nbsp;</p>

<p><strong>Question J. Are you subject to the SEC Conflict Minerals disclosure requirement rule?</strong></p>

<p>Please answer &ldquo;Yes&rdquo; or &ldquo;No&rdquo;.&nbsp; Provide Comments to document your answer<strong>.</strong></p>

<ul>
	<li>The SEC conflict minerals disclosure requirements apply to US exchange-traded companies that are subject to the US Securities Exchange Act. For more information please refer to www.sec.gov.</li>
</ul>

EOT
}

tasks << {
:name => "Complete the Smelter List sheet",
:instructions => <<EOT
<ol>
	<li><strong>Metal Column</strong>: Use the pull down menu to select the metal for which you are entering smelter information.</li>
</ol>

<p>&nbsp;</p>

<ol>
	<li value="2"><strong>Smelter Reference List: </strong>&nbsp;Select from dropdown.&nbsp; This is the list of known smelters as of template release date.&nbsp; If smelter is not listed select &#39;Smelter Not Listed&#39;</li>
</ol>

<p>&nbsp;</p>

<ol>
	<li value="3"><strong>Standard Smelter Names</strong>: &nbsp;If you selected &#39;Smelter Not Listed&#39; in the Smelter Reference List column, fill in smelter name. &nbsp;This field will auto-populate when a smelter name is selected in Smelter Reference List column.</li>
</ol>

<p>&nbsp;</p>

<ol>
	<li value="4"><strong>Smelter Facility Location: Country</strong>: This field will auto-populate when a smelter name is selected in Smelter Reference List column. &nbsp;If you selected &#39;Smelter Not Listed&#39; in Smelter Reference List column, use the pull down menu to select the country location of the smelter facility that processes the minerals that enter your supply chain.&nbsp; This is the physical location of the smelter where the minerals are being processed.</li>
</ol>

<ul style="margin-left: 40px;">
	<li><strong>Do not list the headquarters of the company.&nbsp; Example: Canada</strong></li>
</ul>

<p>&nbsp;</p>

<ol>
	<li value="5"><strong>Smelter Facility Location: Street Address:</strong> &nbsp;Fill in the street address of the smelter facility that processes the minerals that enter your supply chain.&nbsp; This is the physical location of the smelter where the minerals are being processed.</li>
</ol>

<ul style="margin-left: 40px;">
	<li><strong>Do not list the headquarters of the company.&nbsp; Example: 12 Calgary Street</strong></li>
</ul>

<p>&nbsp;</p>

<ol>
	<li value="6"><strong>Smelter Facility Location: City:</strong> &nbsp;Fill in the city location of the smelter facility that processes the minerals that enter your supply chain. This is the physical location of the smelter where the minerals are being processed.</li>
</ol>

<ul style="margin-left: 40px;">
	<li><strong>Do not list the headquarters of the company.</strong> <strong>Example: Montreal</strong></li>
</ul>

<p>&nbsp;</p>

<ol>
	<li value="7"><strong>Smelter Facility Location: State/Province, if applicable</strong>:&nbsp; Fill in the state or province location of the smelter facility that processes the minerals that enter your supply chain.&nbsp; This is the physical location of the smelter where the minerals are being processed.</li>
</ol>

<ul style="margin-left: 40px;">
	<li><strong>Do not list the headquarters of the company.&nbsp; Example: Quebe</strong><strong>c</strong></li>
</ul>

<p>&nbsp;</p>

<ol>
	<li value="8"><strong>Smelter Facility Contact Name:</strong> &nbsp;Fill in the name of the Smelter Facility Contact person who you worked with.</li>
</ol>

<p>&nbsp;</p>

<ol>
	<li value="9"><strong>Smelter Facility Contact Email:</strong> &nbsp;Fill in the email address of the Smelter Facility contact person who was identified above.&nbsp; Example: John.Smith@SmelterXXX.com.</li>
</ol>

<p>&nbsp;</p>

<ol>
	<li value="10"><strong>Proposed next steps, if applicable:</strong> &nbsp;Provide the actions you will take with the smelter if the facility is not listed on the EICC-GeSI CFS list. Example: request smelter facility to be assessed through the CFS program, remove from preferred supplier list, etc.</li>
</ol>

<p>&nbsp;</p>

<ol>
	<li value="11"><strong>Name of Mine(s) or, if recycled or scrap sourced, state &ldquo;recycled&rdquo; or &ldquo;scrap&rdquo;:</strong>&nbsp; Provide the name of the mine that extracted the metal noted in the Metal column.&nbsp; If the metal was provided from &ldquo;recycled&rdquo; or &ldquo;scrap&rdquo; sources, note which (scrap or recycled) in the field provided.</li>
</ol>

<p>&nbsp;</p>

<ol>
	<li value="12"><strong>Location (Country) of Mine(s) or if recycled or scrap sourced, state &ldquo;recycled&rdquo; or &ldquo;scrap&rdquo;: </strong>&nbsp;In the field provided, identify the country in which the mine is located.&nbsp; Example: Australia.&nbsp; If the metal was provided from &ldquo;recycled&rdquo; or &ldquo;scrap&rdquo; sources, note which (scrap or recycled) in the field provided.</li>
</ol>

EOT
}

tasks << {
:name => "Publish the EICC-GeSI Conflict Mineral Reporting Template Declaration Statement",
:instructions => <<EOT
<ol>
	<li>Send the completed EICC-GeSI Conflict Mineral Reporting Template Declaration Statement to the appropriate executives in your Company.</li>
</ol>

<p>&nbsp;</p>

<ol>
	<li value="2">Send the completed EICC-GeSI Conflict Mineral Reporting Template Declaration Statement to your Company&rsquo;s customers who require it as part of their supplier contract.</li>
</ol>

<p>&nbsp;</p>

<ol>
	<li value="3">If your Conflict Minerals Policy states that the current EICC-GeSI Conflict Mineral Reporting Template Declaration Statement will be made available on your website, publish it in the appropriate location.</li>
</ol>

<p>&nbsp;</p>

EOT
}


template.tasks = tasks.to_json
template.save!
