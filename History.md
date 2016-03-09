_04 april 2013_

  * **NOTE** the plugins archives are now kept in the official [RegRipper](http://code.google.com/p/regripper/) site


---


---


---


_18 february 2013_ -
[regripperplugins\_20130218.zip](http://regripperplugins.googlecode.com/files/regripperplugins_20130218.zip)

  * **NEW PLUGIN** by Corey Harrell: "**uac.pl**" that gets UAC configuration values (SOFTWARE)

  * **UPDATE** by Harlan Carvey to "**comdlg32.pl**", many updates (NTUSER)

  * **NOTE** profile software-all was updated
  * **NOTE** profiles '-all' **DO NOT** contain plugins TLN versions: you must create your own profiles or use them directly

  * **NOTE** RegRipperPluginsPackage (**RRPP**) counts **236** plugins


---


_26 september 2012_ -
[regripperplugins\_20120926.zip](http://regripperplugins.googlecode.com/files/regripperplugins_20120926.zip)

  * **NEW PLUGIN** by Harlan Carvey: "**appcertdlls.pl**" that gets entries from AppCertDlls key (SYSTEM)
  * **NEW PLUGIN** by Harlan Carvey: "**appcompatcache.pl**" that parses files from the Shim Cache (SYSTEM)
  * **NEW PLUGIN** by Harlan Carvey: "**appcompatcache\_tln.pl**" that parses files from the Shim Cache, TLN output (SYSTEM)
  * **NEW PLUGIN** by Harlan Carvey: "**applets\_tln.pl**" that gets the content of Applets key, TLN output (NTUSER)
  * **NEW PLUGIN** by Harlan Carvey: "**appspecific.pl**" that gets contents of user's Intellipoint\AppSpecific subkeys (NTUSER)
  * **NEW PLUGIN** by Harlan Carvey: "**ares.pl**" that gets contents of user's Software\Ares key (NTUSER)
  * **NEW PLUGIN** by Corey Harrell: "**backuprestore.pl**" that gets FilesNotToSnapshot, KeysNotToRestore, FilesNotToBackup (SYSTEM)
  * **NEW PLUGIN** by Harlan Carvey: "**compatassist.pl**" that checks user's Compatibility Assistant\Persisted values (NTUSER)
  * **NEW PLUGIN** by Harlan Carvey: "**direct.pl**" that searches Direct keys for MostRecentApplication subkeys (SOFTWARE)
  * **NEW PLUGIN** by Harlan Carvey: "**direct\_tln.pl**" that searches Direct keys for MostRecentApplication subkeys, TLN output (SOFTWARE)
  * **NEW PLUGIN** by Corey Harrell: "**disablesr.pl**" that gets the on/off value for System Restore (SOFTWARE)
  * **NEW PLUGIN** by Harlan Carvey: "**installer.pl**" that determines products install information (SOFTWARE)
  * **NEW PLUGIN** by Harlan Carvey: "**javafx.pl**" that gets contents of user's JavaFX key (NTUSER)
  * **NEW PLUGIN** by Harlan Carvey: "**legacy\_tln.pl**" that lists LEGACY entries in Enum\Root key, TLN output (SYSTEM)
  * **NEW PLUGIN** by Harlan Carvey: "**networklist\_tln.pl**" that collects network info from NetworkList key, TLN output (SOFTWARE)
  * **NEW PLUGIN** by Harlan Carvey: "**osversion.pl**" that checks for OSVersion value, malware related (NTUSER)
  * **NEW PLUGIN** by Corey Harrell: "**prefetch.pl**" that gets the Prefetch Parameters (SYSTEM)
  * **NEW PLUGIN** by Harlan Carvey: "**runmru\_tln.pl**" that gets contents of user's RunMRU key, TLN output (NTUSER)
  * **NEW PLUGIN** by Harlan Carvey: "**shellbags.pl**" that gets contents of users's Shell/BagMRU keys, **Windows7** (USRCLASS)
  * **NEW PLUGIN** by Harlan Carvey: "**sysinternals.pl**" that checks for SysInternals apps keys (NTUSER)
  * **NEW PLUGIN** by Harlan Carvey: "**sysinternals\_tln.pl**" that checks for SysInternals apps keys, TLN output (NTUSER)
  * **NEW PLUGIN** by Harlan Carvey: "**tracing.pl**" that gets list of apps that can be traced (SOFTWARE)
  * **NEW PLUGIN** by Harlan Carvey: "**tracing\_tln.pl**" that gets list of apps that can be traced, TLN output (SOFTWARE)
  * **NEW PLUGIN** by Harlan Carvey: "**trustrecords.pl**" that gets user's Office 2010 TrustRecords values (NTUSER)
  * **NEW PLUGIN** by Harlan Carvey: "**trustrecords\_tln.pl**" that gets user's Office 2010 TrustRecords values, TLN output (NTUSER)
  * **NEW PLUGIN** by Harlan Carvey: "**tsclient\_tln.pl**" that gets contents of user's Terminal Server Client key, TLN output (NTUSER)
  * **NEW PLUGIN** by Harlan Carvey: "**typedpaths\_tln.pl**" that gets contents of user's typedpaths key, TLN output (NTUSER)
  * **NEW PLUGIN** by Harlan Carvey: "**userassist\_tln.pl**" that displays contents of UserAssist subkeys, TLN output (NTUSER)
  * **NEW PLUGIN** by Mari DeGrazia: "**winbackup.pl**" that gets Windows Backup settings (SOFTWARE)
  * **NEW PLUGIN** by Harlan Carvey: "**wpdbusenum.pl**" that gets WpdBusEnumRoot subkey info (SYSTEM)

  * **UPDATE** by Harlan Carvey to "**legacy.pl**", added analysis tip (SYSTEM)
  * **UPDATE** by Harlan Carvey to "**muicache.pl**", the plugin works both on NTUSER and/or USRCLASS hives (NTUSER,USRCLASS)
  * **UPDATE** by Harlan Carvey to "**networklist.pl**", added NameType value reporting (SOFTWARE)
  * **UPDATE** by Harlan Carvey to "**soft\_run.pl**", added support to newer OS and 64 bits (SOFTWARE)
  * **UPDATE** by Harlan Carvey to "**tsclient.pl**", added parsing of Servers key (NTUSER)
  * **UPDATE** by Harlan Carvey to "**userassist.pl**" (NTUSER)

  * **REMOVED TEMPORARILY** plugin "**typedurlstime.pl**", postponed on next packages
  * **REMOVED TEMPORARILY** plugin "**typedurlstime\_tln.pl**", postponed on next packages

  * **REMOVED** plugin "**bagtest.pl**", deprecated
  * **REMOVED** plugin "**bagtest2.pl**", deprecated
  * **REMOVED** plugin "**crashcontrol.pl**", too similar to "**crashdump.pl**"
  * **REMOVED** plugin "**filesnottosnapshot.pl**", superseded by "**backuprestore.pl**"
  * **REMOVED** plugin "**pstools.pl**", superseded by the more general "**sysinternals.pl**" plugin
  * **REMOVED** plugin "**userassist2.pl**", deprecated since "**userassist.pl**" was updated
  * **REMOVED** plugin "**vista\_comdlg32.pl**", deprecated since "**comdlg32.pl**" was updated
  * **REMOVED** plugin "**win7\_ua.pl**", Windows7-RC and Vigenerè encryption are obsolete

  * **NOTE** added profile "**usrclass-all**" for USRCLASS.DAT hive
  * **NOTE** profiles all-all, ntuser-all, sam-all, security-all, software-all, system-all, usrclass-all were updated
  * **NOTE** profiles '-all' **DO NOT** contain plugins TLN versions: you must create your own profiles or use them directly
  * **NOTE** source code repository was switched to GIT and it was aligned to the current release


---


_12 august 2012_ -
[regripperplugins\_20120812.zip](http://regripperplugins.googlecode.com/files/regripperplugins_20120812.zip)
  * **NEW PLUGIN** by Hal Pomeranz: "**ssh\_host\_keys.pl**" that extracts stored Putty and WinSCP host keys from NTUSER hive
  * **NEW PLUGIN** by Hal Pomeranz: "**winscp\_sessions.pl**" that extracts WinSCP saved session data from NTUSER hive (with password decoding)
  * **NOTE** profiles all-all, ntuser-all, sam-all, security-all, software-all and system-all were updated
  * **NOTE** source code repository was aligned to current release
  * **NOTE** RegRipperPlugins now counts **215** plugins


---


_4 july 2012_ -
[regripperplugins\_20120704.zip](http://regripperplugins.googlecode.com/files/regripperplugins_20120704.zip)
  * **NEW PLUGIN** by John Lukach: "**pstools.pl**" that displays the content for PsTools EULA Agreements


---


_3 july 2012_ -
[regripperplugins\_20120703.zip](http://regripperplugins.googlecode.com/files/regripperplugins_20120703.zip)
  * **NEW PLUGIN** by K. Johnson (with Harlan Carvey updates): "**filehistory.pl**" that parses NTUSER FileHistory Registry keys from Windows 8


---


_2 july 2012_ -
[regripperplugins\_20120702.zip](http://regripperplugins.googlecode.com/files/regripperplugins_20120702.zip)
  * **NEW PLUGIN** by Elizabeth Schweinsberg: "**user\_runplus.pl**" that gets contents of the Run, RunOnce, and RunServices keys from NTUSER hive
  * **NEW PLUGIN** by Elizabeth Schweinsberg: "**soft\_runplus.pl**" that gets contents of the Run, RunOnce, and RunServices keys from SOFTWARE hive
  * **NEW PLUGIN** by Elizabeth Schweinsberg: "**svc\_plus.pl**" that gets services, displaied in short format, from SYSTEM hive


---


_12 june 2012_ -
[regripperplugins\_20120612.zip](http://regripperplugins.googlecode.com/files/regripperplugins_20120612.zip)
  * **NEW PLUGIN** by Jason Hale: "**typedurlstime.pl**" that parses and correlates the TypedURLs and TypedURLsTime subkeys
  * **NEW PLUGIN** by Jason Hale: "**typedurlstime\_tln.pl**" that parses and correlates the TypedURLs and TypedURLsTime subkeys (output in TLN format)


---


_28 may 2012_ -
[regripperplugins\_20120528.zip](http://regripperplugins.googlecode.com/files/regripperplugins_20120528.zip)
  * **NEW PLUGIN** by Francesco Picasso: "**internet\_explorer\_cu.pl**" that parses the Internet Explorer info from NTUSER.DAT registry
  * **NEW PLUGIN** by Francesco Picasso: "**internet\_settings\_cu.pl**" that parses the Internet Settings info from NTUSER.DAT registry
  * **REMOVED** plugin "**ie\_main.pl**", since superseded by "internet\_explorer\_cu.pl"
  * **REMOVED** plugin "**iexplore.pl**", since superseded by "internet\_explorer\_cu.pl"
  * **FIXED** plugin "**timezone.pl**", see [Issue14](https://code.google.com/p/regripperplugins/issues/detail?id=14) and see source code comments
  * **FIXED** plugin "**userassist2.pl**", now it parses Windows7 entries, see source code comments
  * **ADDED** profiles with every plugin listed in alphabetical order: all-all (3), ntuser-all (98), sam-all (1), security-all (3), software-all (56), system-all (46)
  * **NOTE** RegRipperPlugins now counts **207** plugins
  * **KNOWN ISSUES:** comdlg32 does not parse Vista/7 subkeys ([Issue 15](https://code.google.com/p/regripperplugins/issues/detail?id=15))


---


_24 february 2012_ -
[regripperplugins\_20120224.zip](http://regripperplugins.googlecode.com/files/regripperplugins_20120224.zip)
  * **NEW PLUGIN** by Adrian Leong: "ccleaner.pl" that gets CCleaner User's Settings from NTUSER.DAT registry
  * **NOTE** RegRipperPlugins now counts **206** plugins


---


_10 february 2012_ -
[regripperplugins\_20120210.zip](http://regripperplugins.googlecode.com/files/regripperpluglins_20120210.zip)
  * **NEW PLUGIN** by Brad Reninger: _EMDMgt.pl_ that parses the EMDMgt registry key located in the SOFTWARE Hive. This registry key identifies the volume serial number of USB devices.


---


_06 february 2012_ -
[regripperplugins\_20120206.zip](http://regripperplugins.googlecode.com/files/regripperpluglins_20120206.zip)
  * **NEW PLUGIN** by Corey Harrell: _spp\_clients.pl_ that lists volumes currenlty monitored by the Volume Shadow Copy Service


---


_01 february 2012_ -
[regripperplugins\_20120201.zip ](http://regripperplugins.googlecode.com/files/regripperplugins_20120201.zip)
  * **NEW PLUGIN** by Corey Harrell: _filesnottosnapshot.pl_ that extracts from SYSTEM registry files and folders not backed up in Volume Shadow Copies


---


_18 november 2011_ -
[regripperplugins\_20111118.zip](http://regripperplugins.googlecode.com/files/regripperplugins_20111118.zip)
  * **NEW PLUGIN** winlivemail.pl (Windows Live Mail parser) by Francesco Picasso
  * **NEW PLUGIN** winlivemsn.pl (Windows Live Messenger parser) by Francesco Picasso
  * **CHANGED** networkcards.pl to include printout of _ServiceName_ to correlate info coming from otherplugins
  * **REMOVED** wlm\_cu.pl plugin, since it's substituted by winlinemsn.pl
  * **REMOVED** TODO.txt, unuseful (let use the RegRipperPlugins Google Code site)


---


_14 october 2011_ -
[regripperplugins\_20111014.zip](http://regripperplugins.googlecode.com/files/regripperplugins_20111014.zip)
  * **NEW PLUGIN** _userinfo.pl_  (Microsoft Office) by Corey Harrell
  * **ADDED** references to _officedocs2010.pl_ as provided by Cameron Howell
  * **REMOVED** the use of "DateTime::Format::WindowsFileTime" from _officedocs2010.pl_ (see [Issue 1](https://code.google.com/p/regripperplugins/issues/detail?id=1)).
  * **PURGED OLD/REDUNDANT PLUGINS** (see [Issue 12](https://code.google.com/p/regripperplugins/issues/detail?id=12)): the process of plugins eliminating and renaming was based to the fact that the new plugins generated the same output of the old one (eventually with enhancement). **_PLEASE UPDATE YOUR PLUGIN LIST FILES_** (otherwise you will get error when trying to use the renamed/delete plugins). As following:
    * eliminated old _comdlg32.pl_ and renamed the plugin _comdlg32a.pl_ to _comdlg32.pl_. Updated version number to be able to compare and track down changes
    * eliminated old _mountdev.pl_ and renamed the plugin _mountdev2.pl_ to _mountdev.pl_. Updated version number to be able to compare and track down changes: current version is 20110901.
    * eliminated _port\_dev.pl_: the current plugin is _removedev.pl_, as renamed by its author Harlan Carvey.
    * eliminated old _timezone.pl_ and renamed the plugin _timezone2.pl_ to _timezone.pl_. Updated version number to be able to compare and track down changes: current version is 20110901.
    * eliminated old _samparse.pl_ and renamed this plugin _sameparse2.pl_ to _samparse.pl_. Updated version number to be able to compare and track down changes: current version is 20110901


---


_30 agust 2011_ -
[regripperplugins\_20110830.zip](http://regripperplugins.googlecode.com/files/regripperplugins_20110830.zip)

  * **ADDED** banner (rptMsg) to all plugins
  * **RESTORED** identation of some "flat" plugins
  * **CHANGED**  plugins' descriptions to share the common template
  * **PURGED** _yahoo.pl_ plugin
  * **FIXED** _shutdown.pl v.20080324_
  * **FIXED** and upgraded _adoberdr.pl v.20100218_
  * **FIXED** _eventlogs.pl v.20081219_


---
