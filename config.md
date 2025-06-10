### Below is a config ini example.

**Terms**

* popup - is the generation of a window that displays a message.  This message can be customized in the varaible "popupmessage".
* popupmessage - Defines a customer message you want to display on the popup window.
* programx - this would be the command line for install the application.
* argsx - Any arguement that need to include.  Example </qn> etc.
* msix - I put this in to help the script determine if it was an msi to make installing easier.

In this exmaple the customer wanted a popup that allowed them to tell the customer a chrome install was kicking off.  Supplying the /qn arguements to install quietly.  Added the variable because in this example an msi was used.

<code>
popup: $True
popupMessage: Please close Chrome for an upgrade!

program1: googlechromestandaloneenterprise64.msi /i
args1: /qn
msi1:  $True

program2:
args2:
msi2:

program3:
args3:
msi3:
</code>
