module SellHelper
def active_tab(tab) 
    if params[:action] == tab
        tab_class = "nav-link active"

    else
        tab_class = "nav-link"
    tab_class

    end

    end
end

