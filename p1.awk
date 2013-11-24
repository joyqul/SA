{ 
    if ($1 !~/d.*/) 
    { 
        {
            size += $5 
        }
        {
            file++
        }
    } 
    if ($1 ~/d.*/)
    {
        dir++
    }
}
{ 
    if (NR <= 5) 
    {
        print NR ": "$5" "$9
    }
} 
END
{ 
    {
        print "Dir num: " dir
    }
    {
        print "File num: " file
    }
    {
        print "total: " size
    }
}
