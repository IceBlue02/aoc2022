program day6
implicit none
    character(len = 4096) :: input
    character(len = 14) :: working
    integer :: i, point, ready

    open(1, file = 'data.txt', status = 'old')
    read(1, *) input
    close(1)

    point = 0;
    ready = 0;

    do i = 1, len(input)
        point = point + 1
        if (point.gt.14) then
            ready = 1
            point = 1
        end if

        working(point:point) = input(i:i)
        print *, working

        if (ready.eq.1) then
            if (alldiff(working).eq.1) then
                print *, i
                exit
            end if
        end if
    end do
contains


integer function alldiff(vals)
    character(len=14), intent(in) :: vals
    integer :: i, j

    alldiff = 1
    do i=1, len(vals)-1
        do j=i+1, len(vals)
            print *, i, j
            if (vals(i:i) == vals(j:j)) then 
                alldiff = 0
                return
            end if
        end do
    end do

    
end function
end program day6