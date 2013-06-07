metadata    :name        => "SimpleRPC Agent For APT Management for Mcollective",
            :description => "Agent To Manage APT",
            :author      => "Mark Stanislav/Anders Vaage",
            :license     => "GPLv2",
            :version     => "1.3",
            :url         => "https://github.com/uib/mcollective-apt",
            :timeout     => 3600

action "upgrades", :description => "Get the total number of packages available for upgrade" do
    display :always

    output :status,
           :description => "Total number of packages available for upgrade",
           :display_as  => "Package Upgrades Available"
end

action "installed", :description => "Get the total number of packages installed" do
    display :always

    output :status,
           :description => "Total number of packages installed",
           :display_as  => "Packages Installed"
end

action "clean", :description => "Remove all package archive files" do
    display :always

    output :status,
           :description => "Status of cleaning execution",
           :display_as  => "Cleaning Execution"
end

action "update", :description => "Update repository information" do
    display :always

    output :status,
           :description => "Status of update exection",
           :display_as  => "Update Execution"
end

action "upgrade", :description => "Perform System Upgrade" do
    display :always

    output :status,
           :description => "Status of upgrade exection",
           :display_as  => "Update Execution"
end

action "force-upgrade", :description => "Perform Forced System Upgrade" do
    display :always

    output :status,
           :description => "Status of upgrade exection",
           :display_as  => "Update Execution"
end

action "distupgrade", :description => "Perform System Dist-Upgrade" do
    display :always

    output :status,
           :description => "Status of upgrade exection",
           :display_as  => "Update Execution"
end

action "force-distupgrade", :description => "Perform Forced System Dist-Upgrade" do
    display :always

    output :status,
           :description => "Status of upgrade exection",
           :display_as  => "Update Execution"
end

action "fixbroken", :description => "Attemt to fix broken packages" do
    display :always

    output :status,
           :description => "Status of fix-broken",
           :display_as  => "Result of fix-broken"
end
