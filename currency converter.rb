require 'gtk3'

class RubyApp < Gtk::Window

    def initialize
        super
          
        init_ui
    end
    def init_ui

        fixed = Gtk::Fixed.new
        add fixed
        #Quit button code start
        button = Gtk::Button.new :label => "Quit"
        button.set_size_request 80, 35      
        button.signal_connect "clicked" do 
            Gtk.main_quit 
        end
        #Quit button code end
        #Short URL button code start
        ok = Gtk::Button.new :label => "Change!"
        ok.set_size_request 80, 35      
        ok.signal_connect "clicked" do 
			if @value == "Morrocan Dirham"
			mad_to_e_d
			elsif @value == "Euro"
				e_to_mad_d
			elsif @value == "Dollar"
				d_to_mad_e
			else
				@transformed.set_text @value
			end
        end
        #Short URL button code end
        #Short URL Entry code start
        @edit = Gtk::Entry.new
        @edit.set_size_request 200, 35
        @transformed = Gtk::Label.new
        @transformed.set_size_request 200, 35
        #############
        cb = Gtk::ComboBoxText.new
        cb.signal_connect "changed" do |w, e|
			@value = w.active_text
            end
        

        cb.append_text 'Morrocan Dirham'
        cb.append_text 'Euro'
        cb.append_text 'Dollar' 

        fixed.put cb, 230, 23

        add fixed
        
        set_title "Gtk::ComboBoxText"
        signal_connect "destroy" do 
            Gtk.main_quit 
        end 
        ##@mad = Gtk::Label.new
        ##@mad.set_size_request 200, 35
        ##@mad.set_text "Morrocan Dirham"
        #Short URL Entry code end      
        fixed.put button, 150, 140
        fixed.put @edit ,20,20
        fixed.put @transformed ,50,80
        fixed.put ok, 50, 140
        ##fixed.put @mad, 230, 18
        set_title  "Money !"
        signal_connect "destroy" do 
            Gtk.main_quit 
        end        

        set_default_size 300, 200
        set_window_position(:center)
        show_all
        
    end
    
    def mad_to_e_d
    		@l = @edit.text.length
			unless @edit.text == "" or @edit.text ==  " "*@l or @edit.text ==  "."*@l
			 @e = @edit.text.to_f * 0.0886717853
			 @d = @edit.text.to_f * 0.12411
            @transformed.set_text @e.to_s + " Euro \n" +@d.to_s + " " *@e.to_s.length + "$ \n"
			else
            @transformed.set_text "Error please input a valid value!"
            end
    end
    def e_to_mad_d
			@l = @edit.text.length
			unless @edit.text == "" or @edit.text ==  " "*@l or @edit.text ==  "."*@l
			 @d   =  @edit.text.to_f * 1.3863
			 @mad =  @edit.text.to_f * 11.2609356
            @transformed.set_text @mad.to_s + " MAD \n" +@d.to_s + " " *@d.to_s.length + "$ \n"
			else
            @transformed.set_text "Error please input a valid value!"
            end

    end
    def d_to_mad_e
			@l = @edit.text.length
			unless @edit.text == "" or @edit.text ==  " "*@l or @edit.text ==  "."*@l
			 @e   = @edit.text.to_f * 0.721344586
			 @mad = @edit.text.to_f * 8.12301494
            @transformed.set_text @e.to_s + " " *@e.to_s.length + " Euro \n" + @mad.to_s + " " *@e.to_s.length + "MAD \n"
			else
            @transformed.set_text "Error please input a valid value!"
            end

    end
    
    def on_changed sender, event, label
        label.set_text sender.active_text
    end
end

  
Gtk.init
    window = RubyApp.new
Gtk.main

