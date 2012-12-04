module MCollective
    module Agent
        class Apt<RPC::Agent
            action "upgrades" do
                reply[:status] = %x[echo -e 'n\n '| /usr/bin/apt-get -q dist-upgrade 2>/dev/null | grep "upgraded," | awk '{ print $1 }'].chomp!
            end

            action "installed" do
                reply[:status] = %x[/usr/bin/dpkg -l 2>/dev/null | grep "^ii" | wc -l].chomp!
            end

            action "clean" do
                reply[:status] = %x[/usr/bin/apt-get clean > /dev/null 2>&1 && echo OK || echo FAILED].chomp!
            end

            action "update" do
                reply[:status] = %x[/usr/bin/apt-get update > /dev/null 2>&1 && echo OK || echo FAILED].chomp!
            end
            action "upgrade" do
                reply[:status] = %x[/usr/bin/apt-get upgrade -y > /dev/null 2>&1 && echo OK || echo FAILED].chomp!
            end
            action "distupgrade" do
                reply[:status] = %x[/usr/bin/apt-get dist-upgrade -y > /dev/null 2>&1 && echo OK || echo FAILED].chomp!
            end
        end
    end
end
