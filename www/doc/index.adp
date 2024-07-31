
<property name="context">{/doc/ajaxhelper/ {Ajax Helper}} {Ajax Helper}</property>
<property name="doc(title)">Ajax Helper</property>
<master>
<h1>Ajax Helper</h1>
<p>Hamilton G. Chua (ham\@solutiongrove.com)<br>
September 2007<br>
v0.87d<br><br><span style="font-weight: bold;">Components :</span><br>
Prototype v1.5.1 (<a href="http://prototypejs.org/" target="_blank">http://prototypejs.org/</a>)<br>
Scriptaculous v1.7.3 Beta (<a href="http://script.aculo.us/" target="_blank">http://script.aculo.us/</a>)<br>
Overlibmws (<a href="http://www.macridesweb.com/oltest/" target="_blank">http://www.macridesweb.com/oltest/</a>)<br>
Curvey Corners (<a href="http://www.curvycorners.net/" target="_blank">http://www.curvycorners.net/</a>)<br>
Yahoo User Interface Library 2.3.0 (<a href="http://developer.yahoo.com/yui/" target="_blank">http://developer.yahoo.com/yui/</a>)<br>
Dojo Toolkit 0.4 (<a href="http://dojotoolkit.com" target="_blank">http://dojotoolkit.com</a>)<br>
ExtJs 1.1.1 (<a href="http://extjs.com" target="_blank">http://extjs.com</a>)</p>
<p><strong>What&#39;s New :</strong></p>
<p>0.87d</p>
<ul>
<li>Uses Lee Denison&#39;s template::head code to load javascript
sources and cascading style sheets</li><li>Removed Dojo javascript sources, users who would like to use
dojo should download it separately from http://dojotoolkit.org</li><li>Added ExtJs javascript sources</li><li>Added helpers for YUI menu, autocomplete and treeview.</li><li>Added ExtJs helpers for Ext.onReady, Ext.Ajax and
Ext.MessageBox</li><li>Additional tests in ajaxhelper/www/tests</li>
</ul>
<p>
<br><span style="font-weight: bold;">Introduction :<br><br>
</span> The Ajax Helper package provides helper Tcl API procs
to generate the javascript from the above listed components to
enable their various features for use in OpenACS applications. The
motivation for this package is to easily enable Web 2.0 like
features in OpenACS applications using the most popular javascript
libraries.<br><br><span style="font-weight: bold;">Prerequisites :<br><br>
</span> The ajax helper package must be installed and mounted
in /ajax . The installer should automatically mount the ajax helper
in /ajax/ upon installation of the package.</p>
<p>Lee Denison&#39;s template::head code must be available. This
code will soon be committed to CVS head after consulting the
community and some more testing.</p>
<p>In the mean time, you can find the files you need to implement
template head from packages/ajaxhlper/www/docs. You should copy the
files into the following locations</p>
<table width="715" border="1">
<tr>
<th width="286" scope="row"><div align="left"><strong>acs-integration-procs.tcl</strong></div></th><td width="413">openacs_root/packages/acs-templatng/tcl/</td>
</tr><tr>
<th scope="row"><div align="left">head-procs.tcl</div></th><td>openacs_root/packages/acs-templatng/tcl/</td>
</tr><tr>
<th scope="row"><div align="left">blank-master.adp</div></th><td>openacs_root/www/</td>
</tr><tr>
<th scope="row"><p align="left">blank-master.tcl</p></th><td>openacs_root/www/</td>
</tr><tr>
<th scope="row"><div align="left">site-master.adp</div></th><td>openacs_root/www/</td>
</tr><tr>
<th scope="row"><div align="left">site-master.tcl</div></th><td>openacs_root/www/</td>
</tr><tr>
<th scope="row"><div align="left">default-master.tcl</div></th><td>openacs_root/www/</td>
</tr><tr>
<th scope="row"><div align="left">default-master.adp</div></th><td>openacs_root/www/</td>
</tr>
</table>
<p>
<br><span style="font-weight: bold;">Javascript Sources :</span>
</p>

As of 0.87d, all required sources and stylesheets are loaded
automatically using Lee Denison&#39;s template::head code.<br>
<br>
<span style="font-weight: bold;">Ajax Procedures :<br><br>
Prototype</span>
 has a pair of javascript functions that allow
programmers to use XMLHTTP. The ajax.updater and ajax.request
functions. See <a href="http://api.prototypejs.org/ajax/Ajax/Updater/">http://api.prototypejs.org/ajax/Ajax/Updater/</a>

and <a href="http://api.prototypejs.org/ajax/Ajax/Request/">http://api.prototypejs.org/ajax/Ajax/Request/</a>

for more information about these javascript functions.<br>
<br>

The Tcl API is used like this<br>
<pre style="border: 1px dashed rgb(153, 153, 153); padding: 5px; overflow: auto; font-family: Andale Mono,Lucida Console,Monaco,fixed,monospace; color: rgb(0, 0, 0); background-color: rgb(238, 238, 238); font-size: 12px; line-height: 14px; width: 100%;"><code>
set request [ah::ajaxrequest -url "/url/to/call" -pars "parameter1=parameter_value&amp;parameter1=parameter_value"]
</code></pre>

The above api will generate an ajax.request javascript function
that is best placed in an  event like "onClick".<br>
<pre style="border: 1px dashed rgb(153, 153, 153); padding: 5px; overflow: auto; font-family: Andale Mono,Lucida Console,Monaco,fixed,monospace; color: rgb(0, 0, 0); background-color: rgb(238, 238, 238); font-size: 12px; line-height: 14px; width: 100%;"><code>
&lt;a href="#" onClick="\@request;noquote\@"&gt;Send Request&lt;/a&gt;
</code></pre>

Consult the api-doc for more information about other parameters you
can pass on to the ah::ajaxrequest proc.<br>
<br>

The ah::ajaxrequest will make an xmlhttp call but does not do
anything about the response. To update content based on the
response from an xmlhttp request, use ah::ajaxupdate. This
procedure will not only make an xmlhttp call but update the
contents of a div or layer with the response text of the xmlhttp
request.<br>
<br>

Here&#39;s an example :<br>
<pre style="border: 1px dashed rgb(153, 153, 153); padding: 5px; overflow: auto; font-family: Andale Mono,Lucida Console,Monaco,fixed,monospace; color: rgb(0, 0, 0); background-color: rgb(238, 238, 238); font-size: 12px; line-height: 14px; width: 100%;"><code>
set js_update_connections [ah::ajaxupdate -container "connections" \
                                -url "/url/to/call \
                                -enclose \
                                -pars "'effects=$effects&amp;limit_n=$limit_n'" \
                                -effect "Fade" \
                                -effectopts "duration: 0.5"]
</code></pre>

On the adp side, you can just put<br>
<pre style="border: 1px dashed rgb(153, 153, 153); padding: 5px; overflow: auto; font-family: Andale Mono,Lucida Console,Monaco,fixed,monospace; color: rgb(0, 0, 0); background-color: rgb(238, 238, 238); font-size: 12px; line-height: 14px; width: 100%;"><code>
&lt;a href="#" onClick="\@js_update_connections;noquote\@"&gt;Update&lt;/a&gt;
</code></pre>
<br>

The "-enclose" parameter tells the procedure to enclose
the resulting script in script tags &lt;script&gt;&lt;/script&gt;.
This is another option in addition to putting the scripts in html
event attributes like onClick, onMouseover or onChange.<br>
<br>

The "-pars" parameter is where you pass the querystring
that you want to send along with the xmlhttp request. Notice that
it takes the form of a querystring that you normally see in the
address bar of your browser. Use this to pass values to the URL you
are making an xmlhttp request to.<br>
<br>

The "-effect" parameter is an optional parameter that
allows you to specify the effect you want to execute after the
container&#39;s content has been updated.<br>
<br>
<span style="font-weight: bold;">Cinematic Effects :<br><br>
</span>
Use ah::effects to generate javascript that allows you
to implement transitional and cinematic effects to html elements.
You will need to consult the scriptaculous documentation <a href="http://madrobby.github.io/scriptaculous/core-effects/" target="_blank">http://madrobby.github.io/scriptaculous/core-effects/</a>

to know what kinds of effects and what kinds of options you can
pass to the effect script.<br>
<br>

The procedure is called in this manner in the tcl file:
<pre style="border: 1px dashed rgb(153, 153, 153); padding: 5px; overflow: auto; font-family: Andale Mono,Lucida Console,Monaco,fixed,monospace; color: rgb(0, 0, 0); background-color: rgb(238, 238, 238); font-size: 12px; line-height: 14px; width: 100%;"><code>
set effect [ah::effect -element "container" -effect "Fade" -options "duration: 1.5"]
</code></pre>
<p>On the adp file you must put the javascript on a click event</p>
<pre style="border: 1px dashed rgb(153, 153, 153); padding: 5px; overflow: auto; font-family: Andale Mono,Lucida Console,Monaco,fixed,monospace; color: rgb(0, 0, 0); background-color: rgb(238, 238, 238); font-size: 12px; line-height: 14px; width: 100%;"><code>
&lt;a href="#" onClick="\@effect;noquote\@"&gt;Show Effect&lt;/a&gt;<br>
</code></pre>
<p>NOTE :<br>
The Effect name and the options are case sensitive.<br><span style="font-weight: bold;"><br></span><span style="font-weight: bold;">
<br>
DHTML Callouts :<br><br>
</span> There is currently basic support for overlibmws. Right
now we are able to create bubble type call outs.<br><br>
In your tcl file ...</p>
<pre style="border: 1px dashed rgb(153, 153, 153); padding: 5px; overflow: auto; font-family: Andale Mono,Lucida Console,Monaco,fixed,monospace; color: rgb(0, 0, 0); background-color: rgb(238, 238, 238); font-size: 12px; line-height: 14px; width: 100%;"><code>
   set onmouseover [ah::bubblecallout -text " Contents of My Popup" ]
</code></pre>

The adp file should have something like this ....<br>
<pre style="border: 1px dashed rgb(153, 153, 153); padding: 5px; overflow: auto; font-family: Andale Mono,Lucida Console,Monaco,fixed,monospace; color: rgb(0, 0, 0); background-color: rgb(238, 238, 238); font-size: 12px; line-height: 14px; width: 100%;"><code>
&lt;a href="#" \@onmouseover;noquote\@ &gt;Link with Popup&lt;/a&gt;<br>
</code></pre>
<br>
<span style="font-weight: bold;">Drag and Drop Sortables :<br><br>
</span>
 Sortables are documented in the scriptaculous wiki
<a href="http://madrobby.github.io/scriptaculous/sortable/">http://madrobby.github.io/scriptaculous/sortable/</a>
.<br>


For sortables to work you will need to define a container which
will hold the elements you want to be sortable.<br>
<br>

Here is what the script looks like<br>
<pre style="border: 1px dashed rgb(153, 153, 153); padding: 5px; overflow: auto; font-family: Andale Mono,Lucida Console,Monaco,fixed,monospace; color: rgb(0, 0, 0); background-color: rgb(238, 238, 238); font-size: 12px; line-height: 14px; width: 100%;"><code>
append scripts [ah::sortable -element "container" -options "tag:'div',only:'portlet',overlap:'horizontal',constraint:false,ghosting:false"]
</code></pre>

You adp page should contain a div with id attribute container. This
"container" should have subcontainers which the above
script will make sortable.
