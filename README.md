fix-win1252characters
=====================

Utilities to find and fix Unicode characters in the range 128 to 159, which usually are the result of incorrect data conversion from Windows 1252 characters.

Unicode characters in this range are all non-printing characters and are also invalid
in HTML output. However, because they are valid XML characters you can have XML documents
with these characters and no parser should complain.

However, when you generate HTML, e.g., with the DITA Open Toolkit, Saxon may fail with an
"Invalid HTML character: " message because Saxon checks for these characters when producing
HTML.

In Windows code page 1252 these characters are real characters: em dash, bullet, curly quotes, and
other "special" characters. You could get these characters as the result of a data conversion
process that does not translate the 1252 characters into the equivalent Unicode characters.

To help with this data problem, this project provides two utilities:

1. An XQuery you can run using Saxon (e.g., through OxygenXML or from the command line) that will find and report 
documents that have these bad characters so you can fix them.

2. An XSLT transform that converts the 1252 characters to the correct Unicode characters. You can run 
this transform against individual files or against sets of files. Unfortunately, because of the way
XSLT works, you have to manage the DOCTYPE declarations for the result files, so there's a little
setup to do.

See http://en.wikipedia.org/wiki/Windows-1252 for information about Windows code page 1252 and a table showing the 
Windows characters and their equivalent Unicode characters.

See http://stackoverflow.com/questions/631406/what-is-the-difference-between-em-dash-151-and-8212 for some
background on the issue.

### XQuery to Find Bad Characters

The query XQuery src/xquery/findWin1252Chars.xquery will process a directory tree and report any files with bad characters.

To run it from Oxygen:
 
1. Select a file in the root directory you want to start from (e.g., Cloudera.ditamap) in the Oxygen project view or open it in the main editor 
2. Create an XQuery transformation scenario using this query as the XQuery file and Saxon as the XQuery engine, 
3. Click the "parameters" button, and set the collectionDir parameter to the variable "${cfdu}". 
4. Run the transform against the file

You should get a result like this, with one entry for each text string in each document that has a bad character:

~~~~
<result>
<doc uri="file:/Users/ekimber/workspace/topics/cm_dg_monitor_service_status.xml"> You can also pull down a menu from an individual service name to go directly to one of the tabs for that service &#x97; to its Status, Instances, Commands, Configuration, Audits, or Charts Library tabs. </doc>
<doc uri="file:/Users/ekimber/workspace/topics/cm_dg_view_service_instance_details.xml">
				&#x97; a single value summarizing the state and health of the role instance. </doc>
</result>
~~~~