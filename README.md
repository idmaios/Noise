# Noise

Simple notification view for in application usage. Based on `NSOperationQueue`. For every notification creates new operation and adds to queue. In `main()` create submitted `UIView`. 

For full customisation notification view you must create own view, and return it in creation closure.