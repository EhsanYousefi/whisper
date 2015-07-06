class HomeController < ApplicationController

  def main
    binding.pry
    app.json name: 'ehsan', other: {
        sex: 12,
        family: 'yousefi'
      }

  end

end