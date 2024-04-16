using btp.spacefarers as bs from '../db/data-models';

@cds.query.limit.default: 10
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
    SelectionFields : [

    ],

    DataPoint #WormholeNavigationRating: {
        Value        : wormholeNavigationSkill,
        TargetValue  : 10,
        Visualization: #Rating
    },
    DataPoint #StardustCollectionBar   : {
        Value        : stardustCollection,
        TargetValue  : 255,
        Visualization: #Progress
    },


    //Columns
    LineItem                           : [
        {
            $Type            : 'UI.DataField',
            Value            : name,
            Label            : 'Name',
            ![@UI.Importance]: #High,
        },
        {
            $Type: 'UI.DataField',
            Value: originPlanet,
            Label: 'Origin Planet',
        },
        {
            $Type: 'UI.DataField',
            Value: spacesuitColor,
            Label: 'Spacesuit Color',
        },
        {
            $Type            : 'UI.DataFieldForAnnotation',
            Label            : 'Wormhole Navigation Rating',
            Target           : '@UI.DataPoint#WormholeNavigationRating',
            ![@UI.Importance]: #High,
        },
        {
            $Type            : 'UI.DataFieldForAnnotation',
            Label            : 'Stardust Collection Bar',
            Target           : '@UI.DataPoint#StardustCollectionBar',
            ![@UI.Importance]: #High
        },
        {
            $Type            : 'UI.DataField',
            Value            : spacesuitColor,
            Label            : 'Spacesuit Color',
            ![@UI.Importance]: #High,
        },
        {
            $Type: 'UI.DataField',
            Value: department.name,
            Label: 'Department',
        },
        {
            $Type: 'UI.DataField',
            Value: position.name,
            Label: 'Position',
        },
    ],

    //Object Page
    HeaderInfo                         : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Spacefarer',
        TypeNamePlural: 'Spacefarers'
    },

    //Facet
    Facets                             : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#Default',
        ID    : 'Default',
        Label : 'General'
    }],

    // Field Group
    FieldGroup #Default                : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: name
            },
            {
                $Type: 'UI.DataField',
                Value: email
            }
        ]
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
