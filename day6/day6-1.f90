program day6
implicit none
    character(len = 4096) :: input
    character(len = 4) :: working
    integer :: i, point, ready

    open(1, file = 'data.txt', status = 'old')
    read(1, *) input
    close(1)

    point = 0;
    ready = 0;

    do i = 1, len(input)
        point = point + 1
        if (point.gt.4) then
            ready = 1
            point = 1
        end if

        working(point:point) = input(i:i)

        if (ready.eq.1) then
            if (alldiff(working).eq.1) then
                print *, i
                exit
            end if
        end if

        print *, working

    end do
contains


integer function alldiff(vals)
    character(len=4), intent(in) :: vals

    alldiff = 1
    if (vals(1:1) == vals(2:2)) then 
        alldiff = 0
        return
    else if (vals(1:1) == vals(3:3))then 
        alldiff = 0
        return
    else if (vals(1:1) == vals(4:4)) then 
        alldiff = 0
        return
    else if (vals(2:2) == vals(3:3)) then
        alldiff = 0
        return
    else if (vals(2:2) == vals(4:4)) then
        alldiff = 0
        return
    else if (vals(3:3) == vals(4:4)) then
        alldiff = 0
        return

    end if
end function
end program day6