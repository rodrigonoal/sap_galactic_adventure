using btp.spacefarers as bs from '../db/data-models';

service SpacefarerService @(requires: 'authenticated-user') {
    @restrict: [{
        grant: '*',
        where: 'originPlanet = $user.originPlanet'
    }]
    entity GalacticSpacefarers as select from bs.GalacticSpacefarers;

    annotate GalacticSpacefarers with @odata.draft.enabled;
    entity Departments         as select from bs.Departments;
    annotate Departments with @odata.draft.enabled;
    entity Positions           as select from bs.Positions;
    annotate Positions with @odata.draft.enabled;

}

annotate SpacefarerService.GalacticSpacefarers with @(UI: {
    SelectionFields    : [
        department_id,
        position_id
    ],

    //Columns
    LineItem           : [
        {
            $Type: 'UI.DataField',
            Value: name
        },
        {
            $Type: 'UI.DataField',
            Value: email
        },
        {
            $Type: 'UI.DataField',
            Value: department_id
        },
        {
            $Type: 'UI.DataField',
            Value: position_id
        },
    ],

    //Object Page
    HeaderInfo         : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Spacefarer',
        TypeNamePlural: 'Spacefarers'
    },

    //Facet
    Facets             : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#Default',
        ID    : 'Default',
        Label : 'General'
    }],

    // Field Group
    FieldGroup #Default: {
        $Type: 'UI.FieldGroupType',
        Data : [{
            $Type: 'UI.DataField',
            Value: name
        },{
            $Type: 'UI.DataField',
            Value: email
        },{
            $Type: 'UI.DataField',
            Value: department_id
        },]
    }
 }) {
    name                    @title: 'Name';
    stardustCollection      @title: 'Stardust Collection';
    wormholeNavigationSkill @title: 'Wormhole Navigation Skill';
    originPlanet            @title: 'Origin Planet';
    spacesuitColor          @title: 'Spacesuit Color';
    email                   @title: 'Email';
    department              @(
        title : 'Department',
        Common: {ValueList: {

            $Type         : 'Common.ValueListType',
            CollectionPath: 'Department',
            Label         : 'Departments',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: department_id,
                    ValueListPorperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListPorperty: 'name'
                }
            ]
        }}
    );
    position                @(
        title : 'Position',
        Common: {ValueList: {

            $Type         : 'Common.ValueListType',
            CollectionPath: 'Position',
            Label         : 'Positions',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: position_id,
                    ValueListPorperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListPorperty: 'name'
                }
            ]
        }}
    );


}
