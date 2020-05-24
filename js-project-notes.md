# JS/Rails Order of Operations Guide (BACKEND)

The JavaScript Project repo has a handful of helpful [READMEs](https://github.com/learn-co-students/js-spa-project-instructions-online-web-sp-000) that outline the requirements for the JS/Rails Project along with project planning tips and a note about what to expect during your review. There is also this [JavaScript Rails API Project Setup README](https://github.com/learn-co-curriculum/mod3-project-week-setup-example) that provides a thorough step by step walkthrough to get your project up and running along with some help OOJS refactoring tips. Lastly, we also wanted to outline a suggested flow of execution to aide you in building your project. We put together this "Order of Operations Guide" for organizing and completing your JS/Rails Project. This guide is based on the 4-part project build. All study groups can be found [here](https://learn.co/study-groups).

The application we will create during the project build series is a "Syllabus Sharing App" for independent study.

 **USER STORY: A user should be able to read and create syllabi based on category**

## Checklist

### PART 1: Planning and Building a Rails API

**BEFORE YOU CODE**
- [X] 1. Check project requirements in [JavaScript READMEs](https://github.com/learn-co-students/js-spa-project-instructions-online-web-sp-000)
- [X] 2. Ideate! What do you want to build?
    - choose a domain you're familiar with!
    - choose a domain you care about
- [X] 3. Wireframing & User Stories
    - Write down your models, their attributes, and their associations
    - "As a user, I can ....."
    - "A user should be able to ....."
    - What does your app _do_?
- [X] 4. Design your MVP = 'Minimum Viable Product' vs. what are my 'stretch goals'
    - Stretch goals - bonus features you want but don't need

**NOW WE'RE READY FOR PROJECT SET UP**

- [X] 5. Generate new [Rails API](https://edgeguides.rubyonrails.org/api_app.html) using `rails new <my_app_name> --database=postgresql --api`
    - (Replace `<my_app_name>` with the actual name of your project)
- [X] 6. Create github repo
- [X] 7. Create a new branch for building out models `git co -b <branch_name>`. 
    example `git co -b category_model`  This way you can always go back to the fresh API.
    - **NOTE**: It is best practice to always create a new branch when working on a new feature/edit to your code. Your master branch should only have working code. Debug in a branch, not in master.

**NOW WE'RE READY TO CODE (BUT JUST OUR MODELS — NO CONTROLLERS OR SERIALIZERS YET)**

**NOTE**: Remember to _**VERTICALLY**_ build your MVP! This means building out one model/feature at a time. DO NOT build out _all_ the models and controllers at the same time. This is the easiest way to get lost in your project very early. Read more about this [here](https://github.com/learn-co-students/js-spa-project-instructions-online-web-sp-000/blob/master/project-planning-tips.md#build-vertically-not-horizontallys).

- [X] 8. Build your models: `rails g model <your_model_name> name` 
example `rails g model Category category_name` 
example for model holding the foreign key `rails g model Activity category:references` will generates an category_id column in the activities table and will modify the activities.rb model to add a belongs_to :category relationship.  This improves db query performance time.

(Make sure you capitalize the first letter of the model name!)
    - Confirm model and migration
    - Model classes
        - for the model that has the belongs_to relationship(foreign key), use 
        `rails g model Activity category:references` will generates an category_id column in the activities table and will modify the activity.rb model to add a belongs_to :category relationship.
        - Because we're using PostGres we need to delete `null: false`, so this migration will be successful.
    - Add seed data for ONLY the model that you are working on.
    - Migrations
    - Then run `rails db:create && rails db:migrate`
    - run `rails db:seed`
    - Associations - Do not declare the relationship just yet. This will cause errors.
        ***** Important! When using postgres for our database, we need to run rails db:create & rails db:migrate 
        before migrating. See above.  Make sure you don't skip that step *****
        Now that our model and table is setup, we should be able to create a new note in the console
    - git add/commit/push
        - go to github repo, click compare and merge request(green box)
        - click create pull request
        - click merge pull request & confirm merge
        - click delete branch
        - check that the merge took place correctly.
        - in terminal, `git co master` Switch to branch master
        - in terminal, `git pull` syncs local environment with github repo
        (Be careful with `git pull` because it will override any code on your local)
        - git branch - shows all of your branches
- [X] 9. Test your models and associations in the console
    - Create some seed data
    - Adjust migrations as needed


### PART 2: Routes, Controllers, Serializers

- [X] 1. Routes
    - Implement _specific_ namespaced routes for _a_ controller **for MVP**
    - REMEMBER! We're _trying_ to build vertically.

      ```ruby
      Rails.application.routes.draw do
        namespace :api do
          namespace :v1 do
            resources :activities, only: [:index, :create]
          end
        end
      end
      ```
    - Run `rails routes` to confirm routes
    - Visit `http://localhost:3000/api/v1/<your_resource_name>` to see error


- [X] 2. Controllers
    - In your console run: `rails g controller api/v1/<your controller_name>` (Make sure you capitalize and the first letter of the controller name!)
    - Build relevant routes for MVP (ex: `index` and `create`)
    - Visit `http://localhost:3000/api/v1/<your_resource_name>` to see JSON data

- [ ] 3. Fast JSON API Serializer
    - Add `gem 'fast_jsonapi'` to your Rails project's Gemfile and run `bundle install`
    - this gem gives us access to rails g serializer <your_resource_name>
    - Create Serializer classes 
      - `rails g serializer <your_resource_name>`
      - `rails g serializer <your_resource_name>`
    - Update Controller Actions
        ```ruby
        class Api::V1::ActivitiesController < ApplicationController
          def index
            activities = Activity.all
            # render json: activities
            render json: ActivitiesSerializer.new(activity)
          end
        end
        ```
    - Adding Attributes
        ```ruby
        class SyllabusSerializer
          include FastJsonapi::ObjectSerializer
          attributes :title, :description, :image_url, :category_id
        end
        ```
    - Accessing Associations (Related Objects)
        ```ruby
        class SyllabusSerializer
          include FastJsonapi::ObjectSerializer
          attributes :title, :description, :image_url, :category_id, :category
        end
        ```
    - Adding Relationships
        - To control the attributes displayed in the association view PART 2 notes on adding relationships


- [ ] 4. **TEST:** Confirm data at your Rails endpoints! (ex: `http://seeda.com/api/v1/syllabuses`)
- [ ] 5. Build out your associated models using this same process. **REMEMBER: Focus on building vertically for MVP** this means only starting with 2 or 3 models before moving on to the frontend.


### PART 3: DOM Manipulation, Events, and Fetch using Rails API
- **JS MANTRA:** When _some event_ happens, I want to make _what kind of_ fetch and then manipulate the DOM _in what way_?
- [ ] 1. `GET` request
- [ ] 2. `POST` request

### PART 4: OOJS Refactor
- [ ] 1. Create a Syllabus Class

### Bonus
- [ ] Leverage a CSS framework to improve the styling of your application
  - Easiest to implement: [Bulma](https://bulma.io/)
  - Most popular: [Bootstrap](https://getbootstrap.com/)
  - Also good: [Semantic UI](https://semantic-ui.com/)
  - Not bootstrap: [Materialize](https://materializecss.com/)

### Confirm
- [ ] You have a large number of small Git commits
- [ ] Your commit messages are meaningful
- [ ] You made the changes in a commit that relate to the commit message