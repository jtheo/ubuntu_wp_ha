#!/bin/bash
#
#https://indigotree.co.uk/automated-wordpress-installation-with-bash-wp-cli/
#
#

cd /var/www/wordpress

# Check if there's already an installation
wp core version

if [ $? -ne 0 ]
then
  echo "Already Installed"
  exit 1
fi

# download the WordPress core files
wp core download

# create the wp-config file
wp core config --dbname=wp-hog --dbuser=marvin --dbpass=FortyTw0

# create database, and install WordPress
wp db create
wp core install --url=http://localhost:8080 --title="The Hitchhiker's Test for the Galaxy"  --admin_user="zaphod" --admin_password="Slartibartfast" --admin_email="zaphod@dadams.com"



# create posts 
wp post create --post_status=publish --post_type=post --post_title='Ode to a Small Lump of Green Putty I Found in My Armpit One Midsummer Morning' --post_content='Putty. Putty. Putty.<br />  Green Putty - Grutty Peen.<br />  Grarmpitutty - Morning!<br />  Pridsummer - Grorning Utty!<br />  Discovery..... Oh.<br />  Putty?..... Armpit?<br />  Armpit..... Putty.<br />  Not even a particularly<br />  Nice shade of green.<br />  As I lick my armpit and shall agree,<br />  That this putty is very well green.'

wp post create --post_status=publish --post_type=post --post_title='Corporate Ipsum' --post_content='Leverage agile frameworks to provide a robust synopsis for high level overviews. Iterative approaches to corporate strategy foster collaborative thinking to further the overall value proposition. Organically grow the holistic world view of disruptive innovation via workplace diversity and empowerment.<br />  <br />  Bring to the table win-win survival strategies to ensure proactive domination. At the end of the day, going forward, a new normal that has evolved from generation X is on the runway heading towards a streamlined cloud solution. User generated content in real-time will have multiple touchpoints for offshoring.<br />  <br />  Capitalize on low hanging fruit to identify a ballpark value added activity to beta test. Override the digital divide with additional clickthroughs from DevOps. Nanotechnology immersion along the information highway will close the loop on focusing solely on the bottom line.'

wp post create --post_status=publish --post_type=post --post_title='Lorem Ipsum' --post_content='Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget mauris in ex interdum maximus eget mattis eros. In eget tempor purus, vitae ullamcorper ante. Integer eu tempor urna. Sed sagittis nisi in nisi dictum ullamcorper. Praesent aliquet, massa maximus laoreet vestibulum, dolor quam vulputate dolor, at mollis nibh metus ut felis. Aenean consectetur mi eu odio aliquet posuere. Proin at efficitur ipsum. Cras fringilla semper lacus, nec tempus ligula vestibulum sit amet. Pellentesque tincidunt iaculis enim congue tincidunt. Aenean convallis ex nec sagittis pretium. Cras tempor convallis neque in mollis. Donec eleifend, dolor in gravida imperdiet, velit metus lobortis augue, sit amet ornare lectus magna vestibulum felis. Pellentesque ac odio finibus, pulvinar leo id, cursus eros. Maecenas urna nulla, feugiat eget auctor sit amet, mollis in lorem. Pellentesque vitae dui maximus, molestie urna sit amet, sagittis erat. Praesent et nisl vitae enim volutpat maximus sed in lectus.'


