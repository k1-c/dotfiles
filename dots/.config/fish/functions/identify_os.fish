function identify_os
    if test -e /etc/os-release
        echo "linux"
    else if test (uname -s) = "Darwin"
        echo "mac"
    else
        echo "unknown"
    end
end
