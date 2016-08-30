<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:resp="http://hmrc.gov.uk/etmp/digitalgateway/ROSM"
	exclude-result-prefixes="xs resp" version="2.0">

	<xsl:variable name="statusTextPresent">
		<xsl:value-of select="boolean(//resp:ETMP_Transaction_Response/resp:ETMP_Transaction_Header/resp:StatusText)" />
	</xsl:variable>

	<xsl:variable name="arnPresent">
		<xsl:value-of select="boolean(//resp:ETMP_Transaction_Response/resp:RegisterWithoutID_Response/resp:ARN)" />
	</xsl:variable>

	<xsl:template match="/">
	<jsonObject>
			<MDGHeader>
				<status>
					<xsl:value-of select="//resp:ETMP_Transaction_Response/resp:ETMP_Transaction_Header/resp:Status" />
				</status>
				<xsl:if test="$statusTextPresent = 'true'">
					<statusText>
						<xsl:value-of select="//resp:ETMP_Transaction_Response/resp:ETMP_Transaction_Header/resp:StatusText" />
					</statusText>
				</xsl:if>

				<processingDate>
					<xsl:value-of select="//resp:ETMP_Transaction_Response/resp:ETMP_Transaction_Header/resp:ProcessingDate" />
				</processingDate>

				<xsl:for-each select="//resp:ETMP_Transaction_Response/resp:ETMP_Transaction_Header/resp:ReturnParameters">
					<returnParameters>
						<paramName>
							<xsl:value-of select="//resp:ETMP_Transaction_Response/resp:ETMP_Transaction_Header/resp:ReturnParameters/resp:ParamName" />
						</paramName>
						<paramValue>
							<xsl:value-of select="//resp:ETMP_Transaction_Response/resp:ETMP_Transaction_Header/resp:ReturnParameters/resp:ParamValue" />
						</paramValue>
					</returnParameters>
				</xsl:for-each>
			</MDGHeader>

			<registerWithoutIDResponse>
				<SAFEID>
					<xsl:value-of select="//resp:ETMP_Transaction_Response/resp:RegisterWithoutID_Response/resp:SAFEID" />
				</SAFEID>

				<xsl:if test="$arnPresent = 'true'">
					<ARN>
						<xsl:value-of select="//resp:ETMP_Transaction_Response/resp:RegisterWithoutID_Response/resp:ARN" />
					</ARN>
				</xsl:if>
			</registerWithoutIDResponse>
		</jsonObject>
	</xsl:template>
</xsl:stylesheet>