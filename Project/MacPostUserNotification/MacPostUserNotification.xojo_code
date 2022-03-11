#tag Module
Protected Module MacPostUserNotification
	#tag Method, Flags = &h0
		Sub MacPostUserNotification(title As String, subTitle As String, informativeText As String, contentImage As Picture, Optional identifier As String)
		  #if TargetCocoa
		    Declare Function alloc Lib "Cocoa" Selector "alloc" (classRef As Ptr) As Ptr
		    Declare Function defaultUserNotificationCenter Lib "Cocoa" Selector "defaultUserNotificationCenter" (classRef As Ptr) As Ptr
		    Declare Function init Lib "Cocoa" Selector "init" (classRef As Ptr) As Ptr
		    Declare Function initWithCGImageSize Lib "Cocoa" Selector "initWithCGImage:size:" (classRef As Ptr, CGImageRef As Ptr, size As NSSize) As Ptr
		    Declare Function NSClassFromString Lib "Cocoa" (className As CFStringRef) As Ptr
		    Declare Sub CFRelease Lib "CoreFoundation" (CFTypeRef As Ptr)
		    Declare Sub deliverNotification Lib "Cocoa" Selector "deliverNotification:" (defaultUserNotificationCenter As Ptr, notification As Ptr)
		    Declare Sub setTitle Lib "Cocoa" Selector "setTitle:" (instanceRef As Ptr, caption As CFStringRef)
		    Declare Sub setSubtitle Lib "Cocoa" Selector "setSubtitle:" (instanceRef As Ptr, caption As CFStringRef)
		    Declare Sub setInformativeText Lib "Cocoa" Selector "setInformativeText:" (instanceRef As Ptr, text As CFStringRef)
		    Declare Sub setIdentifier Lib "Cocoa" Selector "setIdentifier:" (instanceRef As Ptr, value As CFStringRef)
		    Declare Sub setContentImage Lib "Cocoa" Selector "setContentImage:" (instanceRef As Ptr, aNSImage As Ptr)
		    
		    Static NSUserNotificationClass As Ptr = NSClassFromString("NSUserNotification")
		    Static NSUserNotificationCenterClass As Ptr = NSClassFromString("NSUserNotificationCenter")
		    Static NSUserNotificationCenterDefaultCenter As Ptr = defaultUserNotificationCenter(NSUserNotificationCenterClass)
		    Static NSImageClass As Ptr = NSClassFromString("NSImage")
		    
		    // create the user notification instance and populate the properties
		    DIM NSUserNotificationInstance As Ptr = init(alloc(NSUserNotificationClass))
		    
		    if (title <> "") then
		      setTitle NSUserNotificationInstance, title
		    end if
		    
		    if (subTitle <> "") then
		      setSubtitle NSUserNotificationInstance, subTitle
		    end if
		    
		    if (informativeText <> "") then
		      setInformativeText NSUserNotificationInstance, informativeText
		    end if
		    
		    if (identifier <> "") then
		      setIdentifier NSUserNotificationInstance, identifier
		    else
		      setIdentifier NSUserNotificationInstance, App.ExecutableFile.Name
		    end if
		    
		    if (contentImage <> Nil) then
		      DIM aCGImage As Ptr = contentImage.CopyOSHandle(Picture.HandleType.MacCGImage)
		      if (aCGImage <> Nil) then
		        DIM size As NSSize
		        DIM aNSImage As Ptr = initWithCGImageSize(alloc(NSImageClass), aCGImage, size)
		        
		        setContentImage NSUserNotificationInstance, aNSImage
		        CFRelease aCGImage
		      end if
		    end if
		    
		    if (NSUserNotificationInstance <> Nil) then
		      deliverNotification NSUserNotificationCenterDefaultCenter, NSUserNotificationInstance
		    end if
		  #endif
		End Sub
	#tag EndMethod


	#tag Structure, Name = NSSize, Flags = &h21
		width as Double
		height as Double
	#tag EndStructure


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
