      subroutine wt4gen(q,wt4)
      implicit none
      include 'constants.f'
      include 'phasemin.f'
      include 'debug.f'
      include 'breit.f'
c----given a set of momenta generated calculate the weight 
c----which would have been assigned had it been generated by 
c----routine phase4      
      double precision q(mxpart,4),wt4,s1,m1,m2,s2,s2min,s2max,
     . s3,s3min,s3max,dot,xx(2)
      double precision w2,w3,wt0,lambda
      parameter(wt0=one/eight/pi)
      common/x1x2/xx
      wt4=0d0
      s1=two*dot(q,1,2)
      s2=two*dot(q,4,5)
      s3=two*dot(q,6,7)
      m1=sqrt(s1)
      s2min=0d0
      s2max=s1
      if (s2min .gt. s2max) then
c      write(6,*) 's2min > s2max in wt4gen'
c      write(6,*) 's2min in wt4gen',s2min
c      write(6,*) 's2max in wt4gen',s2max
      return
      endif
      if (n2 .eq. 0) then
         w2=s2max-s2min
      elseif (n2 .eq. 1) then
         call breitw1(s2,s2min,s2max,mass2,width2,w2)       
      endif

      m2=sqrt(s2)
      s3min=0d0
      s3max=(m2-m1)**2
      if (s3min .gt. s3max) then
c      write(6,*) 's3min > s3max in wt4gen'
c      write(6,*) 's3min in wt4gen',s3min
c      write(6,*) 's3max in wt4gen',s3max
      return
      endif
      
      if (n3 .eq. 0) then
         w3=s3max-s3min
      elseif (n3 .eq. 1) then
        call breitw1(s3,s3min,s3max,mass3,width3,w3)       
      endif
      lambda=((s1-s2-s3)**2-4d0*s2*s3)

      if (lambda .lt. 0d0) then
      write(6,*) '(lambda .lt. 0d0) in wt4gen',lambda
c      pause
      return
      endif

      lambda=dsqrt(lambda)
      wt4=wt0*w2*w3*lambda/s1
      wt4=-(wt0/twopi)**2*wt4*two*log(taumin)*xx(1)*xx(2)/(xx(1)+xx(2))
      if (debug) write(6,*) 'wt4 in wt4gen',wt4
     
      return
      end






