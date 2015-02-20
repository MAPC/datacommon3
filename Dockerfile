FROM rails:onbuild

VOLUME ["/usr/src/app"]

EXPOSE 5000

CMD ["foreman", "start", "-e", ".env"]

#
#  Build it!
#
#    $ docker build -t "localrails" .
#
#
#  Run it!
#
#    $ docker run -it --rm -v "$(pwd)":/usr/src/app -p 5000:5000 localrails
#
#
#  Access it!
#
#    On Mac!    http://<boot2docker IP>:5000
#
#    On Linux!  http://localhost:5000
#
#
#  Edit it!
#
#    Any changes you make in your local directory will be 
#    reflected at the URL at which you access your app.
#
#
#  Troubleshoot it!
#
#    If you're using boot2docker, open up VirtualBox and
#    make sure host port 5000 is forwarded to guest port 5000.
#
#    Settings might be in Settings > Networking > Port Forwarding.
#  