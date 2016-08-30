<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
	version="2.0">

	<xsl:output method="xml" indent="yes" encoding="UTF-8" />

	<xsl:variable name="transmittingSystem">
		WSO2
	</xsl:variable>

	<xsl:variable name="varIdentification">
		<xsl:value-of select="//registrationDetailsWithoutID/identification" />
	</xsl:variable>

	<xsl:variable name="varOrganizationFlag">
		<xsl:value-of select="boolean(//registrationDetailsWithoutID/Organisation)" />
	</xsl:variable>

	<xsl:variable name="middleNamePresent">
		<xsl:value-of
			select="boolean(//registrationDetailsWithoutID/individual/middleName)" />
	</xsl:variable>

	<xsl:variable name="dateOfBirthPresent">
		<xsl:value-of
			select="boolean(//registrationDetailsWithoutID/individual/dateOfBirth)" />
	</xsl:variable>

	<xsl:variable name="addressLine3Present">
		<xsl:value-of
			select="boolean(//registrationDetailsWithoutID/address/addressLine3)" />
	</xsl:variable>

	<xsl:variable name="addressLine4Present">
		<xsl:value-of
			select="boolean(//registrationDetailsWithoutID/address/addressLine4)" />
	</xsl:variable>

	<xsl:variable name="postalCodePresent">
		<xsl:value-of
			select="boolean(//registrationDetailsWithoutID/address/postalCode)" />
	</xsl:variable>

	<xsl:variable name="phoneNumberPresent">
		<xsl:value-of
			select="boolean(//registrationDetailsWithoutID/contactDetails/phoneNumber)" />
	</xsl:variable>

	<xsl:variable name="mobileNoPresent">
		<xsl:value-of
			select="boolean(//registrationDetailsWithoutID/contactDetails/mobileNo)" />
	</xsl:variable>

	<xsl:variable name="faxNoPresent">
		<xsl:value-of
			select="boolean(//registrationDetailsWithoutID/contactDetails/faxNo)" />
	</xsl:variable>

	<xsl:variable name="emailAddressPresent">
		<xsl:value-of
			select="boolean(//registrationDetailsWithoutID/contactDetails/emailAddress)" />
	</xsl:variable>

	<xsl:variable name="idNumberPresent">
		<xsl:value-of
			select="boolean(//registrationDetailsWithoutID/identification/idNumber)" />
	</xsl:variable>

	<xsl:variable name="issuingInstitutionPresent">
		<xsl:value-of
			select="boolean(//registrationDetailsWithoutID/identification/issuingInstitution)" />
	</xsl:variable>

	<xsl:variable name="issuingCountryCodePresent">
		<xsl:value-of
			select="boolean(//registrationDetailsWithoutID/identification/issuingCountryCode)" />
	</xsl:variable>

	<xsl:template match="/">
		<etmpqry:ETMP_Transaction
			xmlns:etmpqry="http://hmrc.gov.uk/etmp/digitalgateway/ROSM">
			<etmpqry:ETMP_Transaction_Header>
				<etmpqry:TransmittingSystem>
					<xsl:value-of select="$transmittingSystem" />
				</etmpqry:TransmittingSystem>
				<etmpqry:OriginatingSystem>
					<xsl:value-of select="//originatingSystem" />
				</etmpqry:OriginatingSystem>
				<etmpqry:ReceiptDate>
					<xsl:value-of select="//requestTimeStamp" />
				</etmpqry:ReceiptDate>
				<etmpqry:AcknowledgementReference>
					<xsl:value-of select="//correlationId" />
				</etmpqry:AcknowledgementReference>
				<etmpqry:MessageTypes>
					<etmpqry:MessageType>
						<xsl:value-of select="//messageTypes/messageType" />
					</etmpqry:MessageType>
				</etmpqry:MessageTypes>

				<xsl:for-each select="//requestParameters">
					<etmpqry:RequestParameters>
						<etmpqry:ParamName>
							<xsl:value-of select="paramName" />
						</etmpqry:ParamName>
						<etmpqry:ParamValue>
							<xsl:value-of select="paramValue" />
						</etmpqry:ParamValue>
					</etmpqry:RequestParameters>
				</xsl:for-each>

			</etmpqry:ETMP_Transaction_Header>
			<etmpqry:RegisterWithoutID_Request>
				<xsl:choose>
					<xsl:when test="$varOrganizationFlag = 'true'">
						<etmpqry:Organisation>
							<etmpqry:OrganisationName>
								<xsl:value-of
									select="//registrationDetailsWithoutID/organisation/OrganisationName" />
							</etmpqry:OrganisationName>

						</etmpqry:Organisation>
					</xsl:when>
					<xsl:otherwise>

						<etmpqry:Individual>
							<etmpqry:FirstName>
								<xsl:value-of
									select="//registrationDetailsWithoutID/individual/firstName" />
							</etmpqry:FirstName>
							<xsl:if test="$middleNamePresent = 'true'">
								<etmpqry:MiddleName>
									<xsl:value-of
										select="//registrationDetailsWithoutID/individual/middleName" />
								</etmpqry:MiddleName>
							</xsl:if>
							<etmpqry:LastName>
								<xsl:value-of
									select="//registrationDetailsWithoutID/individual/lastName" />
							</etmpqry:LastName>
							<xsl:if test="$dateOfBirthPresent = 'true'">
								<etmpqry:DateOfBirth>
									<xsl:value-of
										select="//registrationDetailsWithoutID/individual/dateOfBirth" />
								</etmpqry:DateOfBirth>
							</xsl:if>
						</etmpqry:Individual>

					</xsl:otherwise>
				</xsl:choose>

				<etmpqry:Address>
					<etmpqry:AddressLine1>
						<xsl:value-of
							select="//registrationDetailsWithoutID/address/addressLine1" />
					</etmpqry:AddressLine1>
					<etmpqry:AddressLine2>
						<xsl:value-of
							select="//registrationDetailsWithoutID/address/addressLine2" />
					</etmpqry:AddressLine2>

					<xsl:if test="$addressLine3Present='true'">
						<etmpqry:AddressLine3>
							<xsl:value-of
								select="//registrationDetailsWithoutID/address/addressLine3" />
						</etmpqry:AddressLine3>

					</xsl:if>

					<xsl:if test="$addressLine4Present = 'true'">
						<etmpqry:AddressLine4>
							<xsl:value-of
								select="//registrationDetailsWithoutID/address/addressLine4" />
						</etmpqry:AddressLine4>
					</xsl:if>

					<xsl:if test="$postalCodePresent = 'true'">
						<etmpqry:PostalCode>
							<xsl:value-of select="//registrationDetailsWithoutID/address/postalCode" />
						</etmpqry:PostalCode>
					</xsl:if>

					<etmpqry:CountryCode>
						<xsl:value-of select="//registrationDetailsWithoutID/address/countryCode" />
					</etmpqry:CountryCode>
				</etmpqry:Address>

				<etmpqry:ContactDetails>
					<xsl:if test="$phoneNumberPresent = 'true'">
						<PhoneNumber>
							<xsl:value-of
								select="//registrationDetailsWithoutID/contactDetails/phoneNumber" />
						</PhoneNumber>
					</xsl:if>

					<xsl:if test="$mobileNoPresent = 'true'">
						<MobileNo>
							<xsl:value-of
								select="//registrationDetailsWithoutID/contactDetails/mobileNo" />
						</MobileNo>
					</xsl:if>

					<xsl:if test="$faxNoPresent = 'true'">
						<FaxNo>
							<xsl:value-of
								select="//registrationDetailsWithoutID/contactDetails/faxNo" />
						</FaxNo>
					</xsl:if>

					<xsl:if test="$emailAddressPresent = 'true'">
						<EmailAddress>
							<xsl:value-of
								select="//registrationDetailsWithoutID/contactDetails/emailAddress" />
						</EmailAddress>
					</xsl:if>
				</etmpqry:ContactDetails>

				<etmpqry:IsAnAgent>
					<xsl:value-of select="//registrationDetailsWithoutID/isAnAgent" />
				</etmpqry:IsAnAgent>

				<etmpqry:IsAGroup>
					<xsl:value-of select="//registrationDetailsWithoutID/isAGroup" />
				</etmpqry:IsAGroup>

				<xsl:if test="$varIdentification = 'true'">
					<etmpqry:Identification>
						<xsl:if test="$idNumberPresent = 'true'">
							<PhoneNumber>
								<xsl:value-of
									select="//registrationDetailsWithoutID/identification/idNumber" />
							</PhoneNumber>
						</xsl:if>

						<xsl:if test="$issuingInstitutionPresent = 'true'">
							<MobileNo>
								<xsl:value-of
									select="//registrationDetailsWithoutID/identification/issuingInstitution" />
							</MobileNo>
						</xsl:if>

						<xsl:if test="issuingCountryCodePresent = 'true'">
							<FaxNo>
								<xsl:value-of
									select="//registrationDetailsWithoutID/identification/issuingCountryCode" />
							</FaxNo>
						</xsl:if>
					</etmpqry:Identification>
				</xsl:if>


			</etmpqry:RegisterWithoutID_Request>
		</etmpqry:ETMP_Transaction>
	</xsl:template>
</xsl:stylesheet>